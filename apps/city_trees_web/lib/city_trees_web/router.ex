defmodule CityTreesWeb.Router do
  use CityTreesWeb, :router

  import CityTreesWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CityTreesWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CityTreesWeb do
    pipe_through [
      :browser,
      :redirect_if_user_is_authenticated
    ]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", CityTreesWeb do
    pipe_through [
      :browser,
      :require_authenticated_user
    ]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live_session :city_trees_dashboard, on_mount: CityTreesWeb.DashboardLive.DashboardLayout do
      live "/", HomeLive.Index, :index
      live "/trees", TreeLive.Index, :index
      live "/trees/new", TreeLive.Index, :new
      live "/trees/:id/edit", TreeLive.Index, :edit

      live "/trees/:id", TreeLive.Show, :show
      live "/trees/:id/show/edit", TreeLive.Show, :edit
    end
  end

  scope "/", CityTreesWeb do
    pipe_through [
      :browser
    ]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
      live_dashboard "/dashboard", metrics: CityTreesWeb.Telemetry
    end
  end
end
