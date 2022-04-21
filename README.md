# IslandsEngine

Project from the book "Functional Web Development with Elixir, OTP, and Phoenix".

Some additions by the current author, including:
- Use of typespecs and dialyzer
- Unit tests
-

## Development workflow

- Test during development: `mix test.watch --stale --max-failures 10 --trace --seed 0`
-

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `islands_engine` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:islands_engine, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/islands_engine>.
