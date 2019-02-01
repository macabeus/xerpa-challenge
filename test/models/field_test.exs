defmodule XerpaTest.Field do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate
  alias Xerpa.Field

  test "should create field" do
    field = Field.new(2, 3)

    assert %Field{max_x: 2, max_y: 3} == field
  end

  test "should fail when try to create field with a negative value" do
    assert_raise Xerpa.Field.InvalidValue, "max value should be greater than zero", fn ->
      Field.new(2, -4)
    end
  end

  test "should check when the coordinate is valid" do
    coordinate = Coordinate.new(1, 3, :north)

    result =
      Field.new(2, 3)
      |> Field.is_valid_coordinate(coordinate)

    assert true == result
  end

  test "should check when the coordinate is invalid" do
    coordinate = Coordinate.new(3, 3, :north)

    result =
      Field.new(2, 3)
      |> Field.is_valid_coordinate(coordinate)

    assert false == result
  end
end
