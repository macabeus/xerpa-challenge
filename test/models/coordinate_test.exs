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

  test "should move forward" do
    coordinate =
      Coordinate.new(0, 1, :north)
      |> Coordinate.move_forward()

    assert %Coordinate{x: 0, y: 2, direction: :north} == coordinate
  end

  test "should spin left" do
    coordinate =
      Coordinate.new(0, 1, :north)
      |> Coordinate.spin_left()

    assert %Coordinate{x: 0, y: 1, direction: :west} == coordinate
  end

  test "should spin right" do
    coordinate =
      Coordinate.new(0, 1, :north)
      |> Coordinate.spin_right()

    assert %Coordinate{x: 0, y: 1, direction: :east} == coordinate
  end
end
