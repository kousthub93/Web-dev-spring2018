defmodule Hangman1Web.PageController do
  use Hangman1Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
