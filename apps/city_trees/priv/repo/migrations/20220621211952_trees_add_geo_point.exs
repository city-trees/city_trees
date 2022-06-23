defmodule CityTrees.Repo.Migrations.TreesAddGeoPoint do
  use Ecto.Migration

  def up do
    execute("SELECT AddGeometryColumn('trees', 'location', 3857, 'POINT', 2)")
    execute("CREATE INDEX trees_location_index on trees USING gist (location)")
  end

  def down do
    execute("ALTER TABLE trees DROP COLUMN location")
    execute("DROP INDEX trees_location_index on trees")
  end
end
