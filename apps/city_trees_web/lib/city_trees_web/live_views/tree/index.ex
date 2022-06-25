defmodule CityTreesWeb.TreeLive.Index do
  use CityTreesWeb, :live_view
  use Phoenix.LiveView

  alias CityTrees.Trees
  alias CityTrees.Trees.Tree

  @impl true
  def mount(_params, _session, socket) do
    IO.puts("mounted")
    trees = list_trees()
    socket = socket
      |> assign(:trees, trees)
      |> push_event("trees", %{trees: trees})

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tree")
    |> assign(:tree, Trees.get_tree!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tree")
    |> assign(:tree, %Tree{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Trees")
    |> assign(:tree, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tree = Trees.get_tree!(id)
    {:ok, _} = Trees.delete_tree(tree)

    {:noreply, assign(socket, :trees, list_trees())}
  end

  defp list_trees do
    Trees.list_trees()
  end
end
