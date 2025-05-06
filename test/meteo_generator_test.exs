defmodule MeteoGeneratorTest do
  use ExUnit.Case
  doctest MeteoGenerator

  test "greets the world" do
    assert MeteoGenerator.hello() == :world
  end
end
