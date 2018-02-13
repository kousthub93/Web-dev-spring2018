defmodule Hangman1Web.PageController do
  use Hangman1Web, :controller
  
  def game(conn, params) do
    render conn, "game.html", game: params["game"]
  end
  def index(conn, _params) do
    render conn, "index.html"
  end
end
