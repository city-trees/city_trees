defmodule CityTrees.TreesTest do
  use CityTrees.DataCase

  alias CityTrees.Trees

  describe "trees" do
    alias CityTrees.Trees.Tree

    import CityTrees.TreesFixtures

    @invalid_attrs %{
      "diameter_high" => nil,
      "diameter_low" => nil,
      "species_id" => nil,
      "longitude" => "10",
      "latitude" => "20"
    }

    test "list_trees/0 returns all trees" do
      tree = tree_fixture()
      assert Trees.list_trees() == [tree]
    end

    test "get_tree!/1 returns the tree with given id" do
      tree = tree_fixture()
      assert Trees.get_tree!(tree.id) == tree
    end

    test "create_tree/1 with valid data creates a tree" do
      valid_attrs = %{
        "diameter_high" => "42",
        "diameter_low" => "42",
        "species_id" => "42",
        "longitude" => "10",
        "latitude" => "20"
      }

      assert {:ok, %Tree{} = tree} = Trees.create_tree(valid_attrs)
      assert tree.diameter_high == 42
      assert tree.diameter_low == 42
      assert tree.species_id == 42
    end

    test "create_tree/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trees.create_tree(@invalid_attrs)
    end

    test "update_tree/2 with valid data updates the tree" do
      tree = tree_fixture()
      update_attrs = %{
        "diameter_high" => 43,
        "diameter_low" => 43,
        "species_id" => 43,
        "longitude" => "10",
        "latitude" => "20"
      }

      assert {:ok, %Tree{} = tree} = Trees.update_tree(tree, update_attrs)
      assert tree.diameter_high == 43
      assert tree.diameter_low == 43
      assert tree.species_id == 43
    end

    test "update_tree/2 with invalid data returns error changeset" do
      tree = tree_fixture()
      assert {:error, %Ecto.Changeset{}} = Trees.update_tree(tree, @invalid_attrs)
      assert tree == Trees.get_tree!(tree.id)
    end

    test "delete_tree/1 deletes the tree" do
      tree = tree_fixture()
      assert {:ok, %Tree{}} = Trees.delete_tree(tree)
      assert_raise Ecto.NoResultsError, fn -> Trees.get_tree!(tree.id) end
    end

    test "change_tree/1 returns a tree changeset" do
      tree = tree_fixture()
      assert %Ecto.Changeset{} = Trees.change_tree(tree)
    end
  end
end
