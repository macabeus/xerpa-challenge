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

  test "should check when the coordinate within the limits" do
    coordinate = Coordinate.new(1, 3, :north)

    result =
      Field.new(2, 3)
      |> Field.coordinated_within_the_limits?(coordinate)

    assert true == result
  end

  test "should check when the coordinate is not within the limits" do
    coordinate = Coordinate.new(3, 3, :north)

    result =
      Field.new(2, 3)
      |> Field.coordinated_within_the_limits?(coordinate)

    assert false == result
  end

  test "should check that there is robot in coordinate" do
    list_robots = [
      %{
        coordinate: %Coordinate{direction: :north, x: 2, y: 3}
      },
      %{
        coordinate: %Coordinate{direction: :north, x: 3, y: 3}
      }
    ]

    coordinate = Coordinate.new(3, 3, :north)

    result = Field.exists_robot_in_this_coordinate?(list_robots, coordinate)

    assert true == result
  end

  test "should check that there is no robot in coordinate" do
    list_robots = [
      %{
        coordinate: %Coordinate{direction: :north, x: 2, y: 3}
      },
      %{
        coordinate: %Coordinate{direction: :north, x: 3, y: 2}
      }
    ]

    coordinate = Coordinate.new(3, 3, :north)

    result = Field.exists_robot_in_this_coordinate?(list_robots, coordinate)

    assert false == result
  end
end
