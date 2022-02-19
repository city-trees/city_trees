defmodule CityTrees.Repo do
  use Ecto.Repo,
    otp_app: :city_trees,
    adapter: Ecto.Adapters.Postgres
end
