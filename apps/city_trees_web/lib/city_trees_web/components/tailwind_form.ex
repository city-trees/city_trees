defmodule TailwindForm do
  use Phoenix.Component
  alias Phoenix.HTML.Form, as: Form
  alias Phoenix.HTML.Tag, as: Tag

  def email_input(assigns) do
    ~H"""
    <div>
      <%= Form.label(
        assigns.form,
        :email,
        "Email address",
        class: "block text-sm font-medium text-gray-700"
      ) %>
      <div class="mt-1">
        <%= Form.email_input(
          assigns.form,
          :email,
          required: true,
          autocomplete: "email",
          class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        ) %>
        <%= error_tag assigns.form, :email %>
      </div>
    </div>
    """
  end

  def password_input(assigns) do
    ~H"""
    <div class="space-y-1">
      <%= Form.label(
        assigns.form,
        :password,
        "Password",
        class: "block text-sm font-medium text-gray-700"
      ) %>
      <div class="mt-1">
        <%= Form.password_input(
          assigns.form,
          :password,
          required: true,
          autocomplete: "current-password",
          class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        ) %>
      </div>
      <%= error_tag assigns.form, :password %>
    </div>
    """
  end

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      Tag.content_tag(:span, translate_error(error),
        class: "invalid-feedback",
        phx_feedback_for: Form.input_name(form, field)
      )
    end)
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(CityTreesWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(CityTreesWeb.Gettext, "errors", msg, opts)
    end
  end
end
