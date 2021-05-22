defmodule Board.Factories do
  alias Board.Repo
  def build(_any, attributes \\ [])

  def build(:user, attributes) do
    attrs = Enum.into(attributes, %{
      email: "hello#{System.unique_integer()}",
      password: "password"
    })

    %Board.Accounts.User{}
      |> struct(attrs)
  end

  def build(:product, attributes) do
    attrs = Enum.into(attributes, %{
      title: "#{System.unique_integer()}"
    })

    %Board.Products.Product{}
      |> struct(attrs)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
