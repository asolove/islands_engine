defmodule IslandsEngine.Guesses do
  alias IslandsEngine.{Coordinate, Guesses}

  @type t() :: %Guesses{hits: MapSet.t(Coordinate.t()), misses: MapSet.t(Coordinate.t())}

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  @spec new :: %IslandsEngine.Guesses{hits: MapSet.t(any), misses: MapSet.t(any)}
  def new(), do: %Guesses{hits: MapSet.new(), misses: MapSet.new()}

  def add(%Guesses{} = guesses, :hit, %Coordinate{} = coordinate),
    do: update_in(guesses.hits, &MapSet.put(&1, coordinate))

  def add(%Guesses{} = guesses, :miss, %Coordinate{} = coordinate),
    do: update_in(guesses.misses, &MapSet.put(&1, coordinate))
end
