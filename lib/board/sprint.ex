defmodule Board.Sprint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sprints" do
    field :end_at, :utc_datetime
    field :start_at, :utc_datetime
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(sprint, attrs) do
    sprint
    |> cast(attrs, [:start_at, :end_at])
    |> validate_required([:start_at, :end_at])
  end
end
