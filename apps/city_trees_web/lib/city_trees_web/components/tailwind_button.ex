defmodule TailwindButton do
  use Phoenix.Component


  def primary(assigns) do
    assigns = assign_new(assigns, :inline, fn -> false end)

    width = case assigns.inline do
        true -> "inline-flex items-center"
        _ -> "w-full flex justify-center"
    end

    class = case assigns.size do
      :small -> "#{width} px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      :medium -> "#{width} px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      :large -> "#{width} px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      :xlarge -> "#{width} px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      :xxlarge -> "#{width} px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    end

    ~H"""
      <button
        type={@type}
        class={class}>
          <%= render_slot(@inner_block) %>
      </button>
    """
  end
end
