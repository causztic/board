defmodule Board.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string, redact: true

      timestamps()
    end

  end
end
