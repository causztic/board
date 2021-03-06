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
alias Board.{Accounts.User, Products.Product, ProductBacklogs.BacklogItem}

# Consider Multi for more complex seeds in the future
# https://curiosum.com/blog/elixir-ecto-database-transactions

Repo.transaction(fn ->
  # Creating a test user
  user = %User{}
    |> User.changeset(%{ email: "test@test.com", password: "secret" })
    |> Repo.insert!

  # Creating a test product
  product = %Product{}
    |> Product.changeset(%{ title: "test product" })
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.insert!

  
  # Creating three backlog items
  # TODO: refactor to use single statement
  backlog_items = Enum.map(0..2, fn(index) ->
      %BacklogItem{}
      |> BacklogItem.changeset(%{ 
          order: index, 
          title: "backlog item #{index}", 
          product_id: product.id
        })
      |> Repo.insert!
    end)
  
  {user, product, backlog_items}
end)

