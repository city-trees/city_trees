defmodule CityTrees.TreesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CityTrees.Trees` context.
  """

  @doc """
  Generate a tree.
  """
  def tree_fixture(attrs \\ %{}) do
    {:ok, tree} =
      attrs
      |> Enum.into(%{
        "latitude" => "20",
        "longitude" => "10",
        "diameter_high" => 42,
        "diameter_low" => 42,
        "species_id" => 42,
        "description" => "some description",

      })
      |> CityTrees.Trees.create_tree()

    tree
  end
end
