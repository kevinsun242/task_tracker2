defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users
  alias TaskTracker.Timeblocks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    users = Users.get_users()
    current_user = get_session(conn, :user_id)

    if current_user do
      underlings = Users.get_underlings(current_user)
      render(conn, "index.html", tasks: tasks, users: users, underlings: underlings)
    else
      render(conn, "index.html", tasks: tasks, users: users)
    end
    
  end

  def new(conn, _params) do
    current_user = get_session(conn, :user_id)
    changeset = Tasks.change_task(%Task{})
    underlings = Users.get_underlings(current_user)
    render(conn, "new.html", changeset: changeset, underlings: underlings)
  end

  def create(conn, %{"task" => task_params}) do
    current_user = get_session(conn, :user_id)
    users = Users.get_users()
    underlings = Users.get_underlings(current_user)
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, underlings: underlings)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    assignee = Users.get_user(task.user_id)
    timeblocks = Timeblocks.get_timeblocks(task.id)


    render(conn, "show.html", task: task, assignee: assignee, timeblocks: timeblocks)
  end

  def edit(conn, %{"id" => id}) do
    current_user = get_session(conn, :user_id)
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    users = Users.get_users()
    underlings = Users.get_underlings(current_user)
    render(conn, "edit.html", task: task, changeset: changeset, underlings: underlings)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    current_user = get_session(conn, :user_id)
    task = Tasks.get_task!(id)
    users = Users.get_users()
    underlings = Users.get_underlings(current_user)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: users, underlings: underlings)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
