defmodule CityTrees.Repo.Migrations.CreateTrees do
  use Ecto.Migration

  def change do
    create table(:trees) do
      add :spiecies, :integer
      add :diameter_low, :integer
      add :diameter_high, :integer

      timestamps()
    end
  end
end
