defmodule Tracker3Web.TokenController do
  use Tracker3Web, :controller
  alias Tracker3.Users.User

  action_fallback Tracker3Web.FallbackController

  def create(conn, %{"email" => email, "pass" => pass}) do
    with {:ok, %User{} = user} <- Tracker3.Users.get_and_auth_user(email, pass) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
end