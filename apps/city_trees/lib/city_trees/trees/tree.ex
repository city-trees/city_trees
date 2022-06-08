defmodule CityTrees.Trees.Tree do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trees" do
    field :diameter_high, :integer
    field :diameter_low, :integer
    field :spiecies_id, :integer
    field :description, :string
    timestamps()
  end

  @doc false
  def changeset(tree, attrs) do
    tree
    |> cast(attrs, [:spiecies_id, :diameter_low, :diameter_high])
    |> validate_required([:spiecies_id, :diameter_low, :diameter_high])
  end
end
