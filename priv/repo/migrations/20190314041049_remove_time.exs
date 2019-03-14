defmodule TaskTracker.Repo.Migrations.RemoveTime do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :time
    end
  end
end
