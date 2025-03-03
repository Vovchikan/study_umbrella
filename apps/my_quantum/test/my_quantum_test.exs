defmodule MyQuantumTest do
  use ExUnit.Case
  doctest MyQuantum

  test "greets the world" do
    assert MyQuantum.hello() == :world
  end
end
