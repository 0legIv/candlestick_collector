use Mix.Config

config :match_manager, CandlestickCollectorWeb.Endpoint,
  http: [:inet6, port: "${PORT}"],
  server: true

config :logger, level: :info

config :candlestick_collector,
  mongo: [
    name: :mongo,
    pool: DBConnection.Poolboy,
    url: "${MONGODB}",
    pool_size: 2,
    pool_overflow: 10,
    timeout: 20_000,
    pool_timeout: 15_000
  ]