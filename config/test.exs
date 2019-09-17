use Mix.Config

config :candlestick_collector,
  mongo: [
    name: :mongo,
    url: "mongodb://127.0.0.1:27017/candlestick_collector_test",
    pool_size: 2,
    pool_overflow: 10,
    timeout: 20_000,
    pool_timeout: 15_000
  ]

config :logger, level: :warn
