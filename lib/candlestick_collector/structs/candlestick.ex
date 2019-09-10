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

  def to_struct(timeframe, open, low, high, top_merchants) do
    
  end

  def to_struct(document) do
   
  end

  def from_struct(struct) do
    end
end