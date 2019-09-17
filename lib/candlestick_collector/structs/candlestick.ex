defmodule CandlestickCollector.Structs.Candlestick do
  defstruct timeframe: nil,
            open: nil,
            low: nil,
            high: nil,
            close: nil,
            open_time: nil,
            close_time: nil

  @type t() :: %__MODULE__{
          timeframe: String.t(),
          open: Float.t(),
          low: Float.t(),
          high: Float.t(),
          close: Float.t(),
          open_time: DateTime.t(),
          close_time: DateTime.t()
        }

  def to_struct(timeframe, open, low, high, close, open_time, close_time) do
    %__MODULE__{
      timeframe: timeframe,
      open: open,
      low: low,
      high: high,
      close: close,
      open_time: open_time,
      close_time: close_time
    }
  end

  def from_struct(struct) do
    Map.from_struct(struct)
  end
end
