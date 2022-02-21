import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.
if config_env() == :prod do
  # Database connection string is stored in fly io secrects
  database_url = System.get_env("DATABASE_URL") || raise "DATABASE_URL not avalibe"

  # Secret is generatedwith mix phx.gen.secret, stored in fly.io secrets.
  secret_key_base = System.get_env("SECRET_KEY_BASE") || raise "SECRET_KEY_BASE not avalibe"

  config :city_trees, CityTrees.Repo,
    url: database_url,
    socket_options: [:inet6],
    pool_size: 10

  config :city_trees_web, CityTreesWeb.Endpoint,
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    secret_key_base: secret_key_base,
    server: true
end
