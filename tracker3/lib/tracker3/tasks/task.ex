defmodule Tracker3.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :assigned_to, :string
    field :body, :string
    field :done, :boolean, default: false
    field :time_spent, :integer
    field :title, :string
    belongs_to :user, Tracker3.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :body, :done, :time_spent, :assigned_to, :user_id])
    |> validate_required([:title, :body, :done, :time_spent, :assigned_to, :user_id])
  end
end
