defmodule MyApp.Work_app.Duration do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Work_app.Duration


  schema "durations" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    belongs_to :work, MyApp.Work_app.Work


    timestamps()
  end

  @doc false
  def changeset(%Duration{} = duration, attrs) do
    duration
    |> cast(attrs, [:start_time, :end_time, :work_id])
    |> validate_required([:start_time, :end_time])
  end
end
