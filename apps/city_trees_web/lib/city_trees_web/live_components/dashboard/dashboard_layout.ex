defmodule CityTreesWeb.DashboardLive.DashboardLayout do
  use CityTreesWeb, :live_component

  def on_mount(_action, _params, _session, socket) do
    socket =
      attach_hook(socket, :set_left_menu, :handle_params,
      fn _params, url, socket ->
          {:cont, assign(socket, left_nav: get_nav(socket, url))}
      end
    )
    {:cont, socket}
  end

  def get_nav(socket, url) do
    path = URI.parse(url).path

    left_menu = [
      {
        "Home",
        "home",
        Routes.home_index_path(socket, :index),
        path == Routes.home_index_path(socket, :index)
      },
      {
        "Trees",
        "globe",
        Routes.tree_index_path(socket, :index),
        String.starts_with?(path, Routes.tree_index_path(socket, :index))
      }
    ]
    left_menu
  end
end
