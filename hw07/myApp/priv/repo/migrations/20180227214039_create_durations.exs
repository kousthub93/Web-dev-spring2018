defmodule MyApp.Repo.Migrations.CreateDurations do
  use Ecto.Migration

  def change do
    create table(:durations) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :work_id, references(:works, on_delete: :nothing)

      timestamps()
    end

    create index(:durations, [:work_id])
  end
end
