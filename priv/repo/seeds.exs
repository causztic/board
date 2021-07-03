# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Board.Repo.insert!(%Board.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Board.Repo
alias Board.{Accounts.User, Products.Product}

# Creating a test user
user = %User{}
  |> User.changeset(%{ email: "test@test.com", password: "secret" })
  |> Repo.insert!

# Creating a test product
%Product{}
|> Product.changeset(%{ title: "test product" })
|> Ecto.Changeset.put_assoc(:users, [user])
|> Repo.insert!
