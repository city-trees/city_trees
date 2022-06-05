defmodule CityTreesWeb.TreeLiveTest do
  use CityTreesWeb.ConnCase

  import Phoenix.LiveViewTest
  import CityTrees.TreesFixtures

  @create_attrs %{diameter_high: 42, diameter_low: 42, spiecies: 42}
  @update_attrs %{diameter_high: 43, diameter_low: 43, spiecies: 43}
  @invalid_attrs %{diameter_high: nil, diameter_low: nil, spiecies: nil}

  defp create_tree(_) do
    tree = tree_fixture()
    %{tree: tree}
  end

  describe "Index" do
    setup [:create_tree]

    test "lists all trees", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.tree_index_path(conn, :index))

      assert html =~ "Listing Trees"
    end

    test "saves new tree", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.tree_index_path(conn, :index))

      assert index_live |> element("a", "New Tree") |> render_click() =~
               "New Tree"

      assert_patch(index_live, Routes.tree_index_path(conn, :new))

      assert index_live
             |> form("#tree-form", tree: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tree-form", tree: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tree_index_path(conn, :index))

      assert html =~ "Tree created successfully"
    end

    test "updates tree in listing", %{conn: conn, tree: tree} do
      {:ok, index_live, _html} = live(conn, Routes.tree_index_path(conn, :index))

      assert index_live |> element("#tree-#{tree.id} a", "Edit") |> render_click() =~
               "Edit Tree"

      assert_patch(index_live, Routes.tree_index_path(conn, :edit, tree))

      assert index_live
             |> form("#tree-form", tree: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tree-form", tree: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tree_index_path(conn, :index))

      assert html =~ "Tree updated successfully"
    end

    test "deletes tree in listing", %{conn: conn, tree: tree} do
      {:ok, index_live, _html} = live(conn, Routes.tree_index_path(conn, :index))

      assert index_live |> element("#tree-#{tree.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tree-#{tree.id}")
    end
  end

  describe "Show" do
    setup [:create_tree]

    test "displays tree", %{conn: conn, tree: tree} do
      {:ok, _show_live, html} = live(conn, Routes.tree_show_path(conn, :show, tree))

      assert html =~ "Show Tree"
    end

    test "updates tree within modal", %{conn: conn, tree: tree} do
      {:ok, show_live, _html} = live(conn, Routes.tree_show_path(conn, :show, tree))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tree"

      assert_patch(show_live, Routes.tree_show_path(conn, :edit, tree))

      assert show_live
             |> form("#tree-form", tree: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#tree-form", tree: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tree_show_path(conn, :show, tree))

      assert html =~ "Tree updated successfully"
    end
  end
end
