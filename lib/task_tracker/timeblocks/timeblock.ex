defmodule TaskTracker.Timeblocks.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timeblocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:task_id])
  end
end
