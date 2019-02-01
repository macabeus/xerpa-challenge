defmodule XerpaTest.Coordinate do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate

  test "should create coordinate" do
    coordinate = Coordinate.new(0, 1, :north)

    assert %Coordinate{x: 0, y: 1, direction: :north} == coordinate
  end

  test "should fail when try to create coordinate with invalid direction" do
    assert_raise Xerpa.Coordinate.InvalidValue, "invalid value for direction", fn ->
      Coordinate.new(0, 1, :invalid)
    end
  end
end
