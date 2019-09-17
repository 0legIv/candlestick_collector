defmodule CandlestickCollector.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    mongo_params = Application.get_env(:candlestick_collector, :mongo)

    children = [
      CandlestickCollector.Scheduler,
      worker(Mongo, [mongo_params], id: :mongo)
    ]

    opts = [strategy: :one_for_one, name: CandlestickCollector.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
