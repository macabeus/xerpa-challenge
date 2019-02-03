defmodule XerpaTest.Output do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias Xerpa.Coordinate
  alias Xerpa.Field
  alias Xerpa.Output

  test "should output a coordinate" do
    coordinate = Coordinate.new(2, 3, :east)

    assert capture_io(fn ->
             Output.say_coordinate(coordinate)
           end) == "2 3 E\n"
  end

  test "should get a blank point in this position" do
    list_robots = [
      %{
        coordinate: %Coordinate{direction: :north, x: 2, y: 3}
      },
      %{
        coordinate: %Coordinate{direction: :south, x: 3, y: 3}
      }
    ]

    assert Output.draw_point(0, 3, list_robots) == "."
  end

  test "should get the position of the robot in this position" do
    list_robots = [
      %{
        coordinate: %Coordinate{direction: :north, x: 2, y: 3}
      },
      %{
        coordinate: %Coordinate{direction: :south, x: 3, y: 3}
      }
    ]

    assert Output.draw_point(2, 3, list_robots) == "N"
  end

  test "should draw the field" do
    list_robots = [
      %{
        coordinate: %Coordinate{direction: :north, x: 2, y: 3}
      },
      %{
        coordinate: %Coordinate{direction: :south, x: 3, y: 3}
      }
    ]

    field = Field.new(4, 5)

    assert capture_io(fn ->
             Output.draw_field(field, list_robots)
           end) == ".....\n.....\n..NS.\n.....\n.....\n.....\n"
  end
end
