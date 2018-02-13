defmodule Hangman1Web.GamesChannel do
  use Hangman1Web, :channel

  alias Memory.Game

   def join("games:" <> name, payload, socket) do
    if authorized?(payload) do

      game = Hangman1.GameBackup.load(name) || Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  
  # Add authorization logic here as required.
  def authorized?(_payload) do
    true
  end

  def handle_in("double", payload, socket) do
    xx = String.to_integer(payload["xx"])
    resp = %{  "xx" => xx, "yy" => 2 * xx }
    {:reply, {:doubled, resp}, socket}
  end


  def handle_in("event", %{"id" => name, "body" => cardValue}, socket) do

    game0 = socket.assigns[:game]
    game1 = Game.event(game0, name,cardValue)
    Hangman1.GameBackup.save(socket.assigns[:name],game1)
    socket = assign(socket, :game, game1)
    {:reply, {:ok, %{ "game" => Game.client_view(game1)}}, socket}
    
  end
  
  def handle_in("wait", %{"name" => name}, socket) do
    
    game0 = socket.assigns[:game]
    game1 = Game.wait(game0)
    Hangman1.GameBackup.save(socket.assigns[:name],game1)
    socket = assign(socket, :game, game1)
    {:reply, {:ok, %{ "game" => Game.client_view(game1)}}, socket}

  end 

  def handle_in("refresh", %{"name" => name}, socket) do
    
    game0 = socket.assigns[:game]
    game1 = Game.new()
    Hangman1.GameBackup.save(socket.assigns[:name],game1)
    socket = assign(socket, :game, game1)
    {:reply, {:ok, %{ "game" => Game.client_view(game1)}}, socket}
    
  end 

end
