use Mix.Config

config :logger, level: :info

config :candlestick_collector,
  mongo: [
    name: :mongo,
    url: "${MONGODB}",
    pool_size: 2,
    pool_overflow: 10,
    timeout: 20_000,
    pool_timeout: 15_000
  ]
