ARG BUILDER_IMAGE="builder"
ARG RUNNER_IMAGE="runner"

FROM ${BUILDER_IMAGE} as builder

# prepare build dir
WORKDIR /app

# Set build ENV
ENV MIX_ENV="prod"
ENV NODE_ENV="production"

# Copy apps
COPY apps apps
COPY config config

# Install deps
COPY mix.exs mix.exs
COPY mix.lock mix.lock

RUN mix deps.get --only prod

# Compile dependacies
RUN mix deps.compile

# Compile static assets
RUN cd apps/city_trees_web && mix assets.deploy && cd ../..

# Copy release configuration
COPY rel rel

# Compile projects
RUN mix compile

# Create Release
RUN mix release


# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

WORKDIR "/app"
RUN chown nobody /app

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/prod/rel/server ./

USER nobody
EXPOSE 4000

CMD /app/bin/server start