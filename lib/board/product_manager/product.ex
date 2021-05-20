defmodule Board.ProductManager.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :title, :string
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
