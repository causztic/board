defmodule Board.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :title, :string
    has_many :backlog_items, Board.Products.BacklogItem
    many_to_many :users, Board.Accounts.User, join_through: "users_products"

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
