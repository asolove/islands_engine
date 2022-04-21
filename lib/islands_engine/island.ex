defmodule IslandsEngine.Island do
  alias IslandsEngine.{Coordinate, Island}

  @type t() :: %Island{
          coordinates: MapSet.t(Coordinate.t()),
          hit_coordinates: MapSet.t(Coordinate.t())
        }
  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  @spec new(atom(), Coordinate.t()) :: any
  def new(type, %Coordinate{} = upper_left) do
    with [_ | _] = offsets <- offsets(type),
         %MapSet{} = coordinates <- add_coordinates(offsets, upper_left) do
      {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
    else
      error -> error
    end
  end

  @spec types :: list(atom())
  def types(), do: [:atoll, :dot, :l_shape, :s_shape, :square]

  @spec overlaps?(Island.t(), Island.t()) :: boolean()
  def overlaps?(existing_island, new_island),
    do: not MapSet.disjoint?(existing_island.coordinates, new_island.coordinates)

  @spec guess(Island.t(), Coordinate.t()) :: :miss | {:hit, Island.t()}
  def guess(island, coordinate) do
    case MapSet.member?(island.coordinates, coordinate) do
      true -> {:hit, update_in(island.hit_coordinates, &MapSet.put(&1, coordinate))}
      false -> :miss
    end
  end

  @spec forested?(Island.t()) :: boolean()
  def forested?(island), do: MapSet.equal?(island.coordinates, island.hit_coordinates)

  defp offsets(:square), do: [{0, 0}, {0, 1}, {1, 0}, {1, 1}]
  defp offsets(:atoll), do: [{0, 0}, {0, 1}, {1, 1}, {2, 0}, {2, 1}]
  defp offsets(:dot), do: [{0, 0}]
  defp offsets(:l_shape), do: [{0, 0}, {1, 0}, {2, 0}, {2, 1}]
  defp offsets(:s_shape), do: [{0, 1}, {0, 2}, {1, 0}, {1, 1}]
  defp offsets(_), do: {:error, :invalid_island_shape}

  defp add_coordinates(offsets, upper_left) do
    Enum.reduce_while(offsets, MapSet.new(), fn offset, coords ->
      add_coordinate(coords, upper_left, offset)
    end)
  end

  defp add_coordinate(coords, %Coordinate{row: row, col: col}, {row_offset, col_offset}) do
    case Coordinate.new(row + row_offset, col + col_offset) do
      {:ok, coordinate} -> {:cont, MapSet.put(coords, coordinate)}
      {:error, :invalid_coordinate} -> {:halt, {:error, :invalid_coordinate}}
    end
  end
end
