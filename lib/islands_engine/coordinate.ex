defmodule IslandsEngine.Coordinate do
  alias __MODULE__

  @moduledoc """
  A `Coordinate` struct represents a valid space on the game board.
  It has a `:row` and `:col`, both of which are in 1..10
  """

  @type t() :: %IslandsEngine.Coordinate{col: number(), row: number()}

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_range 1..10

  @spec new(number(), number()) ::
          {:error, :invalid_coordinate}
          | {:ok, t()}
  def new(row, col) when row in @board_range and col in @board_range do
    {:ok, %Coordinate{row: row, col: col}}
  end

  def new(_row, _col), do: {:error, :invalid_coordinate}
end
