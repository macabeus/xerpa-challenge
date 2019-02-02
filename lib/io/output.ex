defmodule Xerpa.Output do
  alias Xerpa.Coordinate
  alias Xerpa.Output

  @direction_output_map %{north: "N", south: "S", east: "E", west: "W"}

  def say_robot(name) do
    %{coordinate: coordinate} = :sys.get_state(name)

    Output.say_coordinate(coordinate)
  end

  def say_coordinate(%Coordinate{x: x, y: y, direction: direction}) do
    IO.puts("#{x} #{y} #{@direction_output_map[direction]}")
  end
end
