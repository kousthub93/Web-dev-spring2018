defmodule MyAppWeb.DurationController do
  use MyAppWeb, :controller

  alias MyApp.Work_app
  alias MyApp.Work_app.Duration

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    durations = Work_app.list_durations()
    render(conn, "index.json", durations: durations)
  end

  def create(conn, %{"duration" => duration_params}) do
    with {:ok, %Duration{} = duration} <- Work_app.create_duration(duration_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", duration_path(conn, :show, duration))
      |> render("show.json", duration: duration)
    end
  end

  def show(conn, %{"id" => id}) do
    duration = Work_app.get_duration!(id)
    render(conn, "show.json", duration: duration)
  end

  def update(conn, %{"id" => id, "duration" => duration_params}) do
    duration = Work_app.get_duration!(id)

    with {:ok, %Duration{} = duration} <- Work_app.update_duration(duration, duration_params) do
      render(conn, "show.json", duration: duration)
    end
  end

  def delete(conn, %{"id" => id}) do
    duration = Work_app.get_duration!(id)
    with {:ok, %Duration{}} <- Work_app.delete_duration(duration) do
      send_resp(conn, :no_content, "")
    end
  end
end
