defmodule CandlestickCollector.Handler do
  require Logger

  alias CandlestickCollector.Utils.DateTimeUtils
  alias CandlestickCollector.Handler.Requests
  alias CandlestickCollector.Structs.Candlestick
  alias CandlestickCollector.Storage.MongoAdapter

  @timeframe_values %{
    "1m" => [minutes: -1],
    "5m" => [minutes: -5],
    "1h" => [hours: -1],
    "4h" => [hours: -4],
    "1d" => [days: -1],
    "1w" => [weeks: -1]
  }

  @spec get_candlestick(String.t()) :: {:ok, %Candlestick{}} | {:error, atom()}
  def get_candlestick(interval) do
    case Map.get(@timeframe_values, interval) do
      nil ->
        {:error, :wrong_time_interval}

      shift_interval ->
        end_time = DateTime.utc_now()
        start_time = DateTimeUtils.shift_time(end_time, shift_interval)

        start_time_timestamp = DateTimeUtils.date_to_timestamp(start_time)
        end_time_timestamp = DateTimeUtils.date_to_timestamp(end_time)

        with {:ok, trades} <-
               Requests.get_last_trades_by_instrument_and_time(
                 end_time_timestamp,
                 start_time_timestamp,
                 1000
               ) do
          calculate_candlestick(trades, interval, start_time, end_time)
        end
    end
  end

  @spec write_to_db(%Candlestick{}) :: {:ok, %Mongo.InsertOneResult{}} | {:error, atom()}
  def write_to_db(candlestick) do
    candlestick_map = Candlestick.from_struct(candlestick)
    MongoAdapter.insert_one("candlesticks", candlestick_map)
  end

  defp calculate_candlestick([], _, start_time, end_time) do
    Logger.info(
      "No data for the interval #{DateTime.to_string(start_time)} - #{
        DateTime.to_string(end_time)
      }"
    )

    {:error, :no_data}
  end

  @spec calculate_candlestick(List.t(), String.t(), Integer.t(), Integer.t()) ::
          {:ok, %Candlestick{}} | {:error, atom()}
  defp calculate_candlestick(trades, interval, start_time, end_time) do
    open =
      trades
      |> List.first()
      |> Map.get("price")

    close =
      trades
      |> List.last()
      |> Map.get("price")

    low =
      trades
      |> Enum.min_by(fn trade -> trade["price"] end)
      |> Map.get("price")

    high =
      trades
      |> Enum.max_by(fn trade -> trade["price"] end)
      |> Map.get("price")

    {:ok, Candlestick.to_struct(interval, open, low, high, close, start_time, end_time)}
  end
end
