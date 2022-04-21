defmodule IslandsEngine.Board do
  alias IslandsEngine.{Coordinate, Island}

  @type t() :: map()

  @spec new :: t()
  def new(), do: %{}

  @spec position_island(Board.t(), atom(), IslandsEngine.Island.t()) ::
          {:error, :overlapping_island} | Board.t()
  def position_island(board, key, %Island{} = island) do
    case overlaps_existing_island?(board, key, island) do
      true -> {:error, :overlapping_island}
      false -> Map.put(board, key, island)
    end
  end

  @spec all_islands_positioned?(any) :: boolean
  def all_islands_positioned?(board), do: Enum.all?(Island.types(), &Map.has_key?(board, &1))

  def all_forested?(board) do
    Enum.all?(board, fn {_key, island} -> Island.forested?(island) end)
  end

  def guess(board, %Coordinate{} = coordinate) do
    board
    |> check_all_islands(coordinate)
    |> guess_response(board)
  end

  defp check_all_islands(board, coordinate) do
    Enum.find_value(board, :miss, fn {type, island} ->
      case Island.guess(island, coordinate) do
        {:hit, island} -> {type, island}
        :miss -> false
      end
    end)
  end

  defp guess_response(:miss, board), do: {:miss, :none, false, board}

  defp guess_response({type, island}, board) do
    board = %{board | type => island}
    forested_island = if Island.forested?(island), do: type, else: :none
    win_symbol = if all_forested?(board), do: :win, else: :no_win
    {:hit, forested_island, win_symbol, board}
  end

  defp overlaps_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
      new_key != key and Island.overlaps?(island, new_island)
    end)
  end
end
