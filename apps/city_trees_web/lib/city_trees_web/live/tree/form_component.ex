defmodule CityTreesWeb.TreeLive.FormComponent do
  use CityTreesWeb, :live_component

  alias CityTrees.Trees

  @impl true
  def update(%{tree: tree} = assigns, socket) do
    changeset = Trees.change_tree(tree)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"tree" => tree_params}, socket) do
    changeset =
      socket.assigns.tree
      |> Trees.change_tree(tree_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"tree" => tree_params}, socket) do
    save_tree(socket, socket.assigns.action, tree_params)
  end

  defp save_tree(socket, :edit, tree_params) do
    case Trees.update_tree(socket.assigns.tree, tree_params) do
      {:ok, _tree} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tree updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_tree(socket, :new, tree_params) do
    case Trees.create_tree(tree_params) do
      {:ok, _tree} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tree created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
