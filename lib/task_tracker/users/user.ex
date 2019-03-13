defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :manager, :boolean, default: false
    field :manager_id, :id
    has_many :tasks, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :manager, :manager_id])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
