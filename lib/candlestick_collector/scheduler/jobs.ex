defmodule CandlestickCollector.Scheduler.Jobs do
  alias CandlestickCollector.Handler

  def get_candlestick(interval) do
    interval
    |> Handler.get_candlestick()
    |> Handler.write_to_db()
  end
end