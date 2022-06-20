





defmodule BrandStyle do
  use Phoenix.Component

  def logo(assigns) do
    ~H"""
      <img class="h-16 w-auto" src="/images/logo_legacy.jpg" alt="company logo">
    """
  end
end
