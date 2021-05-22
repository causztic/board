defmodule Board.Repo.Migrations.CreateUsersProducts do
  use Ecto.Migration

  def change do
    create table(:users_products, primary_key: false) do
      add :product_id, references(:products)
      add :user_id, references(:users)
    end

    create index(:users_products, :product_id)
    create index(:users_products, :user_id)
    create unique_index(:users_products, [:product_id, :user_id])
  end
end
