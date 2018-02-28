defmodule MyAppWeb.WorkController do
  use MyAppWeb, :controller

  alias MyApp.Work_app
  alias MyApp.Work_app.Work

  alias MyApp.Work_app.Duration

  alias MyApp.Accounts
  alias MyApp.Accounts.User


  def index(conn, _params) do
    works = Work_app.list_works()
    render(conn, "index.html", works: works)
  end

  #change made
  def new(conn, _params) do

    new_work = %Work{ assigned_by: conn.assigns[:current_user].name }
    current_user = conn.assigns[:current_user]
    #changeset = Work_app.change_work(%Work{})
    changeset = Work_app.change_work(new_work)
    users = Accounts.list_users()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"work" => work_params}) do

    users = Accounts.list_users()
    new_work = %Work{ assigned_by: conn.assigns[:current_user].name }

    case Work_app.create_work(work_params) do
      {:ok, work} ->
        conn
          |> put_flash(:info, "Work created successfully.")
          |> redirect(to: work_path(conn, :show, work))
        {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
      end
  end

  def show(conn, %{"id" => id}) do
    work = Work_app.get_work!(id)
    durations = Work_app.list_durations()
    render(conn, "show.html", work: work, durations: durations)
  end

  def edit(conn, %{"id" => id}) do

    work = Work_app.get_work!(id)
    users = Accounts.list_users()
    changeset = Work_app.change_work(work)
    render(conn, "edit.html", work: work, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "work" => work_params}) do
    work = Work_app.get_work!(id)
    users = Accounts.list_users()
    {min_value,temp_value} = Integer.parse(work_params["done_time"]["minute"])
    num = rem min_value, 15

    if (num != 0) do 
      conn
      |> put_flash(:info, "Minutes should be in multiples of 15")
      |> redirect(to: work_path(conn, :edit, work))

    else

      case Work_app.update_work(work, work_params) do
        {:ok, work} ->
          conn
          |> put_flash(:info, "Work updated successfully.")
          |> redirect(to: work_path(conn, :show, work))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", work: work, changeset: changeset, users: users)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    work = Work_app.get_work!(id)
    {:ok, _work} = Work_app.delete_work(work)

    conn
    |> put_flash(:info, "Work deleted successfully.")
    |> redirect(to: work_path(conn, :index))
  end
end
