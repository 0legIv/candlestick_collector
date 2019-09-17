defmodule CandlestickCollector.HandlerTest do
  use ExUnit.Case

  alias CandlestickCollector.Handler
  alias CandlestickCollector.Structs.Candlestick
  alias CandlestickCollector.Storage.MongoAdapter

  @wrong_interval "99h"

  @correct_interval "1w"

  test "get_candlestick with the wrong interval" do
    assert {:error, :wrong_time_interval} = Handler.get_candlestick(@wrong_interval)
  end

  test "get_candlestick with the correct interval" do
    assert {:ok, %Candlestick{}} = Handler.get_candlestick(@correct_interval)
  end

  test "get_candlestick and write it to the database" do
    {:ok, candlestick} = Handler.get_candlestick(@correct_interval)

    assert {:ok,
            %Mongo.InsertOneResult{
              acknowledged: true,
              inserted_id: id
            }} = Handler.write_to_db(candlestick)

    assert %{"_id" => id} = MongoAdapter.find_one("candlesticks", %{"_id" => id})
  end
end
