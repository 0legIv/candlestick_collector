defmodule CandlestickCollector.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    mongo_params = Application.get_env(:candlestick_collector, :mongo)
    IO.inspect mongo_params

    children = [
      # Start the endpoint when the application starts
      CandlestickCollectorWeb.Endpoint,
      CandlestickCollector.Scheduler,
      worker(Mongo, [mongo_params], id: :mongo)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CandlestickCollector.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CandlestickCollectorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
