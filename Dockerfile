FROM bitwalker/alpine-elixir:1.7.4 AS builder
WORKDIR /source

ARG MIX_ENV=prod
ENV MIX_ENV=${MIX_ENV}

COPY . .
RUN mix clean && \
    mix deps.get && \
    mix compile && \
    mix distillery.release --env=${MIX_ENV}

FROM bitwalker/alpine-erlang:21.1.1

ARG VERSION=0.1.0
ARG MIX_ENV=prod

ENV HOME=app \
    MIX_ENV=${MIX_ENV} \
    MONGODB="mongodb://mongo:27017/candlestick_collector" \
    PORT=4001 \
    REPLACE_OS_VARS=true 

WORKDIR /${HOME}
COPY --from=builder /source/_build/${MIX_ENV}/rel/candlestick_collector/releases/${VERSION}/candlestick_collector.tar.gz /tmp/
RUN tar -xf /tmp/candlestick_collector.tar.gz --directory . \
    && rm /tmp/candlestick_collector.tar.gz

ENTRYPOINT ["bin/candlestick_collector"]
CMD ["foreground"]