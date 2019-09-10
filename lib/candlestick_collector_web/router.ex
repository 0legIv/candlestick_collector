defmodule CandlestickCollectorWeb.Router do
  use CandlestickCollectorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CandlestickCollectorWeb do
    pipe_through :api
  end
end
