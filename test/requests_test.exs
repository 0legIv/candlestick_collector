defmodule CandlestickCollector.RequestsTest do
  use ExUnit.Case

  alias CandlestickCollector.Handler.Requests

  test "get_last_trades_by_instrument_and_time with the incorrect arguments" do
    assert {:error, "non negative integer required"} =
             Requests.get_last_trades_by_instrument_and_time(-123, 123, 10)
  end

  test "get_last_trades_by_instrument_and_time with the correct arguments" do
    assert {:ok, trades} = Requests.get_last_trades_by_instrument_and_time(123, 123, 10)
  end
end
