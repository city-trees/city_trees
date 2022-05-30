# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :city_trees,
  ecto_repos: [CityTrees.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :city_trees, CityTrees.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :city_trees_web,
  ecto_repos: [CityTrees.Repo],
  generators: [context_app: :city_trees]

# Configures the endpoint
config :city_trees_web, CityTreesWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CityTreesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CityTrees.PubSub,
  live_view: [signing_salt: "NiTFWfwc"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(
        js/app.js
        --bundle
        --target=es2020
        --outdir=../priv/static/assets --external:/fonts/* --external:/images/*
      ),
    cd: Path.expand("../apps/city_trees_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

  # Configure taiwind build
  # @see https://github.com/phoenixframework/tailwind
  config :tailwind,
  version: "3.0.24",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/city_trees_web/assets", __DIR__),
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :tailwind, version: "3.0.24"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
