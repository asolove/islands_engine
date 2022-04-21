defmodule IslandsEngine.BoardTest do
  use ExUnit.Case
  alias IslandsEngine.{Board, Coordinate, Island}

  test "stores islands after placing on board" do
    board = Board.new()
    {:ok, square_origin} = Coordinate.new(2, 1)
    {:ok, square} = Island.new(:square, square_origin)
    board = Board.position_island(board, :square, square)

    assert Map.get(board, :square) == square
  end

  test "does not allow islands to overlap" do
    board = Board.new()
    {:ok, square_origin} = Coordinate.new(1, 1)
    {:ok, square} = Island.new(:square, square_origin)
    board = Board.position_island(board, :square, square)

    {:ok, dot_origin} = Coordinate.new(2, 2)
    {:ok, dot} = Island.new(:dot, dot_origin)
    assert {:error, :overlapping_island} == Board.position_island(board, :dot, dot)
  end
end
