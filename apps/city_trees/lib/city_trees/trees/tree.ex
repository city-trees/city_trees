defmodule CityTrees.Trees.Tree do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trees" do
    field :diameter_high, :integer
    field :diameter_low, :integer
    field :spiecies, :integer

    timestamps()
  end

  @doc false
  def changeset(tree, attrs) do
    tree
    |> cast(attrs, [:spiecies, :diameter_low, :diameter_high])
    |> validate_required([:spiecies, :diameter_low, :diameter_high])
  end
end
