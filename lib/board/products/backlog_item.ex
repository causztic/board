defmodule Board.Products.BacklogItem do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:title, :estimate, :id, :description, :order]}
  schema "backlog_items" do
    field :description, :string
    field :estimate, :integer
    field :title, :string
    field :order, :integer
    belongs_to :product, Board.Products.Product

    timestamps()
  end

  @doc false
  def changeset(backlog_item, attrs) do
    backlog_item
    |> cast(attrs, [:title, :description, :estimate, :product_id, :order])
    |> validate_required([:title])
  end
end
