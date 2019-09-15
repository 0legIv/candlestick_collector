defmodule CandlestickCollector.Utils.DateTimeUtils do
  def date_to_timestamp(date) do
    date
    |> DateTime.to_unix(:millisecond)
  end

  def current_time_timestamp() do
    DateTime.utc_now()
    |> date_to_timestamp
  end

  def shift_time(time, interval) do
    time
    |> Timex.shift(interval)
    |> date_to_timestamp
  end
end
