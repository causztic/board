defmodule Board.Products.BacklogItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "backlog_items" do
    field :description, :string
    field :estimate, :integer
    field :title, :string
    belongs_to :product, Board.Products.Product

    timestamps()
  end

  @doc false
  def changeset(backlog_item, attrs) do
    backlog_item
    |> cast(attrs, [:title, :description, :estimate])
    |> validate_required([:title])
  end
end
