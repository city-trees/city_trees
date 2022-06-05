defmodule TailwindAlert do
  use Phoenix.Component


  def warning(assigns) do
    assigns = assign_new(assigns, :class, fn -> nil end)

    ~H"""
      <.inner_alert class={@class} type={:warning}>
        <:icon>
          <!-- Heroicon name: solid/check-circle -->
          <svg class="h-5 w-5 text-green-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
          </svg>
        </:icon>
        <:message>
          <%= @message %>
        </:message>
      </.inner_alert>
    """
  end

  def info(assigns) do
    assigns = assign_new(assigns, :class, fn -> nil end)

    ~H"""
      <.inner_alert class={@class} type={:info}>
        <:icon>
          <!-- Heroicon name: solid/information-circle -->
          <svg class="h-5 w-5 text-blue-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
          </svg>
        </:icon>
        <:message>
          <%= @message %>
        </:message>
      </.inner_alert>
    """
  end

  def success(assigns) do
    assigns = assign_new(assigns, :class, fn -> nil end)

    ~H"""
      <.inner_alert class={@class} type={:success}>
        <:icon>
          <!-- Heroicon name: solid/check-circle -->
          <svg class="h-5 w-5 text-green-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
          </svg>
        </:icon>
        <:message>
          <%= @message %>
        </:message>
      </.inner_alert>
    """
  end

  def error(assigns) do
    assigns = assign_new(assigns, :class, fn -> nil end)

    ~H"""
      <.inner_alert class={@class} type={:error}>
        <:icon>
          <!-- Heroicon name: solid/x-circle -->
          <svg class="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
          </svg>
        </:icon>
        <:message>
          <%= @message %>
        </:message>
      </.inner_alert>
    """
  end

  defp inner_alert(assigns) do
    wrapper_color_class = case assigns.type do
      :error -> "bg-red-50"
      :info -> "bg-blue-50"
      :warning -> "bg-yellow-50"
      :success -> "bg-green-50"
    end

    wrapper_class = case assigns.class do
      nil -> "rounded-md #{wrapper_color_class} p-4"
      _ -> "#{assigns.class} rounded-md #{wrapper_color_class} p-4"
    end

    message_class = case assigns.type do
      :error -> "text-sm font-medium text-red-800"
      :info -> "text-sm font-medium text-blue-700"
      :warning -> "text-sm font-medium text-yellow-700"
      :success -> "text-sm font-medium text-green-700"
    end


    ~H"""
    <div class={wrapper_class}>
      <div class="flex">
        <div class="flex-shrink-0">
          <%= render_slot(@icon) %>
        </div>
        <div class="ml-3 flex-1 md:flex md:justify-between">
          <h3 class={message_class}>
            <%= render_slot(@message) %>
          </h3>
        </div>
      </div>
    </div>
    """
  end
end
