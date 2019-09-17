defmodule CandlestickCollector.Handler.Requests do
  require Logger

  @spec get_last_trades_by_instrument_and_time(Integer.t(), Integer.t(), Integer.t()) ::
          {:ok, List.t()} | {:error, atom()}
  def get_last_trades_by_instrument_and_time(end_time, start_time, count) do
    request = "https://test.deribit.com/api/v2/public/get_last_trades_by_instrument_and_time"

    params = [
      params: %{
        "instrument_name" => "BTC-PERPETUAL",
        "start_timestamp" => start_time,
        "count" => count,
        "end_timestamp" => end_time,
        "include_old" => true,
        "sorting" => "asc"
      }
    ]

    with {:ok, %HTTPoison.Response{body: body}} <- do_request(request, params),
         {:ok, %{"result" => %{"trades" => trades}}} <- Jason.decode(body) do
      {:ok, trades}
    else
      {:ok, %{"error" => %{"data" => %{"param" => param, "reason" => reason}}}} ->
        Logger.error("Error for the param: #{param}, reason: #{inspect(reason)}")
        {:error, reason}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("HTTPoison error, reason: #{inspect(reason)}")
        {:error, reason}

      {:error, %Jason.DecodeError{position: position}} ->
        Logger.error("Json decode error, position: #{position}")
        {:error, :decode_error}
    end
  end

  defp do_request(request, params),
    do: HTTPoison.get(request, [], params)
end
