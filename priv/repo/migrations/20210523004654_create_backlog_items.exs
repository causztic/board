defmodule Board.Repo.Migrations.CreateProductBacklogs do
  use Ecto.Migration

  def change do
    create table(:backlog_items) do
      add :title, :string
      add :description, :string
      add :estimate, :integer
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:backlog_items, [:product_id])
  end
end
