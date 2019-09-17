use Mix.Config

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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
