FROM crystallang:1.17-alpine as base

WORKDIR /app

RUN apt-get update \
    && apt-get install -y ffmpeg

RUN --mount=type=cache,target=/root/.cache/shards,sharing=locked \
    --mount=type=bind,source=shard.yml,target=shard.yml \
    --mount=type=bind,source=shard.lock,target=shard.lock,rw \
    shards install

FROM base as final

RUN --mount=type=bind,target=. crystal build -o /bin/app main.cr
