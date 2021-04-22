defmodule Inmana.Repo.Migrations.CreateRestaurantesTable do
  use Ecto.Migration

  def change do
    create table(:restaurants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string, null: false
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:restaurants, [:email])
  end
end
