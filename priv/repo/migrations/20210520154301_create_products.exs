defmodule Board.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string

      timestamps()
    end

  end
end
