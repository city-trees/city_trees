

export MIX_ENV="prod"
export NODE_ENV="production"

mix deps.get --only prod

# Compile dependacies
mix deps.compile

# Compile static assets
cd apps/city_trees_web && mix assets.deploy && cd ../..

# Compile projects
mix compile

# Create Release
mix release

rm -rf city_trees_web.zip
zip -r city_trees_web.zip ./_build

scp -r -i ./terraform/.ssh/deploy -P 2211 city_trees_web.zip devops@49.12.207.142:/home/devops/
