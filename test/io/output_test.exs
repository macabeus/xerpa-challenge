defmodule XerpaTest.Output do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias Xerpa.Coordinate
  alias Xerpa.Output

  test "should output a coordinate" do
    coordinate = Coordinate.new(2, 3, :east)

    assert capture_io(fn ->
             Output.say_coordinate(coordinate)
           end) == "2 3 E\n"
  end
end
