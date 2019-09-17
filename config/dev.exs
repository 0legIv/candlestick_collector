use Mix.Config

config :candlestick_collector,
  mongo: [
    name: :mongo,
    url: "mongodb://127.0.0.1:27017/candlestick_collector",
    pool_size: 2,
    pool_overflow: 10,
    timeout: 20_000,
    pool_timeout: 15_000
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
