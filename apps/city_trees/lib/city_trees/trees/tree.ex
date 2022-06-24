defmodule CityTrees.Trees.Tree do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:location]}
  schema "trees" do
    field :diameter_high, :integer
    field :diameter_low, :integer
    field :species_id, :integer
    field :description, :string
    field :location, Geo.PostGIS.Geometry
    timestamps()
  end

  @doc false
  def changeset(tree, attrs) do
    tree
    |> cast(attrs, [:species_id, :diameter_low, :diameter_high, :location])
    |> validate_required([:species_id, :diameter_low, :diameter_high, :location])
  end
end
