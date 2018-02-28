defmodule MyAppWeb.DurationView do
  use MyAppWeb, :view
  alias MyAppWeb.DurationView

  def render("index.json", %{durations: durations}) do
    %{data: render_many(durations, DurationView, "duration.json")}
  end

  def render("show.json", %{duration: duration}) do
    %{data: render_one(duration, DurationView, "duration.json")}
  end

  def render("duration.json", %{duration: duration}) do
    %{id: duration.id,
      start_time: duration.start_time,
      end_time: duration.end_time}
  end
end
