defmodule CandlestickCollector.Scheduler.Jobs do
  require Logger

  alias CandlestickCollector.Handler

  def get_candlestick(interval) do
    case Handler.get_candlestick(interval) do
      {:ok, candlestick} ->
        Handler.write_to_db(candlestick)

      {:error, reason} ->
        {:error, reason}
    end
  end
end
