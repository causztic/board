defmodule Board.Repo.Migrations.AddOrderToProductBacklogs do
  use Ecto.Migration

  def change do
    alter table("backlog_items") do
      add :order, :integer, default: 0
    end

    create index("backlog_items", [:order])
  end
end
