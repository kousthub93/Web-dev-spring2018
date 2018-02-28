defmodule MyAppWeb.DurationControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Work_app
  alias MyApp.Work_app.Duration

  @create_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], start_time: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], start_time: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{end_time: nil, start_time: nil}

  def fixture(:duration) do
    {:ok, duration} = Work_app.create_duration(@create_attrs)
    duration
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all durations", %{conn: conn} do
      conn = get conn, duration_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create duration" do
    test "renders duration when data is valid", %{conn: conn} do
      conn = post conn, duration_path(conn, :create), duration: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, duration_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_time" => ~N[2010-04-17 14:00:00.000000],
        "start_time" => ~N[2010-04-17 14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, duration_path(conn, :create), duration: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update duration" do
    setup [:create_duration]

    test "renders duration when data is valid", %{conn: conn, duration: %Duration{id: id} = duration} do
      conn = put conn, duration_path(conn, :update, duration), duration: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, duration_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_time" => ~N[2011-05-18 15:01:01.000000],
        "start_time" => ~N[2011-05-18 15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, duration: duration} do
      conn = put conn, duration_path(conn, :update, duration), duration: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete duration" do
    setup [:create_duration]

    test "deletes chosen duration", %{conn: conn, duration: duration} do
      conn = delete conn, duration_path(conn, :delete, duration)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, duration_path(conn, :show, duration)
      end
    end
  end

  defp create_duration(_) do
    duration = fixture(:duration)
    {:ok, duration: duration}
  end
end
