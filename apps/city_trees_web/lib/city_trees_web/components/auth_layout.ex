defmodule AuthLayout do
  use Phoenix.Component

  def layout(assigns) do
    ~H"""
    <div class="min-h-full flex">
      <div class="flex-1 flex flex-col justify-center py-12 px-4 sm:px-6 lg:flex-none lg:px-20 xl:px-24">
        <div class="mx-auto w-full max-w-sm lg:w-96">
          <div>
            <img class="h-12 w-auto" src="https://tailwindui.com/img/logos/workflow-mark-indigo-600.svg" alt="Workflow">
            <h2 class="mt-6 text-3xl font-extrabold text-gray-900">
              <%= assigns.title %>
            </h2>
          </div>

          <div class="mt-8">
            <div class="mt-6">
              <%= render_slot(@inner_block) %>
            </div>
          </div>
        </div>
      </div>
      <div class="hidden lg:block relative w-0 flex-1">
        <img class="absolute inset-0 h-full w-full object-cover" src="/images/mike-benna-SBiVq9eWEtQ-unsplash.jpg" alt="">
      </div>
    </div>
    """
  end
end
