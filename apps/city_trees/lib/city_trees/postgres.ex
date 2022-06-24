Postgrex.Types.define(
  CityTrees.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)

defimpl Jason.Encoder, for: Geo.Point do
  def encode(struct, _opts) do
    Geo.JSON.encode!(struct) |> Jason.encode!
  end
end
