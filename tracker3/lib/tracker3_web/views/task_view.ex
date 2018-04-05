defmodule Tracker3Web.TaskView do
  use Tracker3Web, :view
  alias Tracker3Web.TaskView
  alias Tracker3Web.UserView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      title: task.title,
      body: task.body,
      done: task.done,
      time_spent: task.time_spent,
      assigned_to: task.assigned_to,
      user: render_one(task.user, UserView, "user.json")}
  end
end
