defmodule Tracker3Web.PageController do
  use Tracker3Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
