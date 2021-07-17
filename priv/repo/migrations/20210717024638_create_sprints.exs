defmodule Board.Repo.Migrations.CreateSprints do
  use Ecto.Migration

  def change do
    create table(:sprints) do
      add :start_at, :utc_datetime
      add :end_at, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:sprints, [:product_id])
  end
end
