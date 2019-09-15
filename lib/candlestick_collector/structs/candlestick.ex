defmodule CandlestickCollector.Structs.Candlestick do
  defstruct timeframe: nil,
            open: nil,
            low: nil,
            high: nil,
            close: nil

  @type t() :: %__MODULE__{
          timeframe: String.t(),
          open: Float.t(),
          low: Float.t(),
          high: Float.t(),
          close: Float.t()
        }

  def to_struct(timeframe, open, low, high, close) do
    %__MODULE__{
      timeframe: timeframe,
      open: open,
      low: low,
      high: high,
      close: close
    }
  end

  def from_struct(struct) do
    Map.from_struct(struct)
  end
end
