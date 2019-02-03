defmodule Xerpa.Output do
  @compile if Mix.env() == :test, do: :export_all

  alias Xerpa.Coordinate
  alias Xerpa.Field
  alias Xerpa.Output

  @direction_output_map %{north: "N", south: "S", east: "E", west: "W"}

  def say_robot(name) do
    %{coordinate: coordinate} = :sys.get_state(name)

    Output.say_coordinate(coordinate)
  end

  def say_coordinate(%Coordinate{x: x, y: y, direction: direction}) do
    IO.puts("#{x} #{y} #{@direction_output_map[direction]}")
  end

  def say_field(field) do
    list_robots = Xerpa.DynamicSupervisor.list_robots()

    draw_field(field, list_robots)
  end

  # Privates

  defp draw_point(x, y, list_robots) do
    point_value =
      Enum.find(list_robots, fn %{coordinate: %Coordinate{x: robot_x, y: robot_y}} ->
        x == robot_x and y == robot_y
      end)

    case point_value do
      nil -> "."
      %{coordinate: %Coordinate{direction: direction}} -> @direction_output_map[direction]
    end
  end

  defp draw_field(%Field{max_x: max_x, max_y: max_y}, list_robots) do
    Enum.each((max_y)..0, fn y ->
      Enum.each(0..(max_x), fn x ->
        IO.write(draw_point(x, y, list_robots))
      end)

      IO.puts("")
    end)
  end
end
