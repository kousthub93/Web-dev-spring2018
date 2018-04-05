defmodule Tracker3Web.Router do
  use Tracker3Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tracker3Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  # Other scopes may use custom stacks.
   scope "/api/v1", Tracker3Web do
     pipe_through :api
     resources "/tasks", TaskController, except: [:new, :edit]
     resources "/users", UserController, except: [:new, :edit]
     post "/token", TokenController, :create
   end
end
