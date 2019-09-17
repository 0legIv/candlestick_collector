defmodule CandlestickCollector.Utils.DateTimeUtils do
  def date_to_timestamp(date),
    do: DateTime.to_unix(date, :millisecond)

  def shift_time(time, interval),
    do: Timex.shift(time, interval)
end
