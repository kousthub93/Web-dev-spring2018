# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tracker3.Repo.insert!(%Tracker3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Seeds do
  alias Tracker3.Repo
  alias Tracker3.Users.User
  alias Tracker3.Tasks.Task
 
  def run do
    p = Comeonin.Argon2.hashpwsalt("password1")
    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "alice", email: "alice@gmail.com", password_hash: p })
    b = Repo.insert!(%User{ name: "bob", email: "bob@gmail.com", password_hash: p })


    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, body: "Hi, I'm Alice", title: "name of the user", assigned_to: "alice", time_spent: 15, done: true })
    Repo.insert!(%Task{ user_id: b.id, body: "Hi, I'm bob", title: "name of the user", assigned_to: "bob", time_spent: 15, done: true})
  end
end

Seeds.run
