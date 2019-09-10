use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :candlestick_collector, CandlestickCollectorWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :candlestick_collector,
  mongo: [
    name: :mongo,
    pool: DBConnection.Poolboy,
    url: "172.17.0.2:27017/candlestick_collector",
    pool_size: 2,
    pool_overflow: 10,
    timeout: 20_000,
    pool_timeout: 15_000
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
