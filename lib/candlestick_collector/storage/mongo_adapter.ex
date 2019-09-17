defmodule CandlestickCollector.Storage.MongoAdapter do
  require Logger

  @mongo_pid :mongo

  def insert_one(collection, doc) do
    case Mongo.insert_one(@mongo_pid, collection, doc, []) do
      {:ok, insert_result} ->
        Logger.info("Document inserted: #{inspect(doc, pretty: true)}")
        {:ok, insert_result}

      {:error, reason} ->
        Logger.error("Mongo error: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
