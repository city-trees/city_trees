defmodule CityTrees.Repo.Migrations.CreateTrees do
  use Ecto.Migration

  def change do
    create table(:trees) do
      add :spiecies_id, :integer
      add :diameter_low, :integer
      add :diameter_high, :integer
      add :description, :string
      timestamps()
    end
  end
end
