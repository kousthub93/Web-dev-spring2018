defmodule MyAppWeb.PageController do
  use MyAppWeb, :controller

  alias MyApp.Accounts
  alias MyApp.Accounts.User
  
  alias MyApp.Work_app
  alias MyApp.Work_app.Work

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
  	#render conn, "feed.html"
  	users = Accounts.list_users()
    works = Work_app.list_works()
    #new_work = %Work{ user_id: conn.assigns[:current_user].id }
    new_work = %Work{ assigned_by: conn.assigns[:current_user].name }
    changeset = Work_app.change_work(new_work)
    render conn, "feed.html", works: works, changeset: changeset, users: users 
  end
end
