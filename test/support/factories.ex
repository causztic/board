defmodule Board.Factories do
  use ExMachina.Ecto, repo: Board.Repo

  def user_factory do
    %Board.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "password",
    }
  end

  def product_factory do
    %Board.Products.Product{
      title: "#{System.unique_integer()}"
    }
  end

  def backlog_item_factory do
    %Board.ProductBacklogs.BacklogItem{
      title: "#{System.unique_integer()}",
      description: "",
      order: 0
    }
  end
end
