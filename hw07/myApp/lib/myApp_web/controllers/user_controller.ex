defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller

  alias MyApp.Accounts
  alias MyApp.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    current_user = conn.assigns[:current_user]
    
    if current_user.manager_id==nil do
      manager = %User{name: "na"}

    else
      manager = Accounts.get_user(current_user.manager_id)

    end

    render(conn, "index.html", users: users, current_user: current_user, manager: manager)
  end

  def new(conn, _params) do
    users = Accounts.list_users()
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    users = Accounts.list_users()
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    users = Accounts.list_users()

    if user.manager_id==nil do
      manager = %User{name: "na"}

    else
      manager = Accounts.get_user(user.manager_id)

    end
    
    render(conn, "show.html", user: user, manager: manager, users: users)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    users = Accounts.list_users()
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
