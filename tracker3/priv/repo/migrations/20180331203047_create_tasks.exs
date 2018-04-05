defmodule Tracker3.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :body, :text
      add :done, :boolean, default: false, null: false
      add :time_spent, :integer
      add :assigned_to, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
