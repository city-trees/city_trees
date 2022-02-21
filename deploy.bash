

export MIX_ENV="prod"
export NODE_ENV="production"

mix deps.get --only prod

# Compile dependacies
mix deps.compile

# Compile static assets
cd apps/city_trees_web && mix assets.deploy && cd ../..

# Copy release configuration
COPY rel rel

# Compile projects
mix compile

# Create Release
mix release

scp -r -i ./terraform/.ssh/deploy -P 2211 ./_build/ devops@49.12.207.142:/build
