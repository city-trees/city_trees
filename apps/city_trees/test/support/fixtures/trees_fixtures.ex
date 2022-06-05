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
        diameter_high: 42,
        diameter_low: 42,
        spiecies: 42
      })
      |> CityTrees.Trees.create_tree()

    tree
  end
end
