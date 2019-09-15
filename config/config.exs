# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :candlestick_collector, CandlestickCollectorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DPvG2Qj64S4LMiCqYimb1TZ3GPbAsf7bHzinU5WPjwNF3UrkF1VX4rG864Rt8WMx",
  render_errors: [view: CandlestickCollectorWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CandlestickCollector.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :candlestick_collector, CandlestickCollector.Scheduler,
  jobs: [
    {"* * * * *", {CandlestickCollector.Scheduler.Jobs, :get_candlestick, ["1m"]}},
    {"*/5 * * * *", {CandlestickCollector.Scheduler.Jobs, :get_candlestick, ["5m"]}},
    {"0 * * * *", {CandlestickCollector.Scheduler.Jobs, :get_candlestick, ["1h"]}},
    {"0 */4 * * *", {CandlestickCollector.Scheduler.Jobs, :get_candlestick, ["4h"]}},
    {"0 0 * * *", {CandlestickCollector.Scheduler.Jobs, :get_candlestick, ["1d"]}},
    {"0 0 * * 0", {CandlestickCollector.Scheduler.Jobs, :get_candlestick, ["1w"]}}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
