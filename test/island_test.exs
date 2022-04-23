defmodule IslandsEngine.IslandTest do
  use ExUnit.Case
  alias IslandsEngine.{Board, Coordinate, Island}

  describe "Island.guess/2" do
    setup do
      {:ok, hit_coordinate} = Coordinate.new(4, 4)
      {:ok, island} = Island.new(:dot, hit_coordinate)
      {:ok, miss_coordinate} = Coordinate.new(2, 2)
      {:ok, island: island, hit_coordinate: hit_coordinate, miss_coordinate: miss_coordinate}
    end

    test "guess and miss", context do
      assert :miss = Island.guess(context.island, context.miss_coordinate)
    end

    test "guess and hit", context do
      assert {:hit, %Island{coordinates: coordinates, hit_coordinates: hit_coordinates} = island2} =
               Island.guess(context.island, context.hit_coordinate)

      assert MapSet.size(coordinates) == 1
      assert MapSet.size(coordinates) == 1
    end
  end

  describe "Island.forested?/1" do
    setup do
      {:ok, hit_coordinate} = Coordinate.new(4, 4)
      {:ok, island} = Island.new(:dot, hit_coordinate)
      {:ok, miss_coordinate} = Coordinate.new(2, 2)
      {:ok, island: island, hit_coordinate: hit_coordinate}
    end

    test "returns if all spaces hit", context do
      assert false == Island.forested?(context.island)
      {:hit, island2} = Island.guess(context.island, context.hit_coordinate)
      assert true == Island.forested?(island2)
    end

    # TODO: test more interesting island shape cases
  end
end
