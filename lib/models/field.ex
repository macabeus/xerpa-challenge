defmodule Xerpa.Field do
  @compile if Mix.env() == :test, do: :export_all

  alias Xerpa.Coordinate
  alias Xerpa.Field

  @enforce_keys [:max_x, :max_y]
  defstruct [:max_x, :max_y]

  def new(max_x, max_y) do
    validate_max_value!(max_x)
    validate_max_value!(max_y)

    %Field{max_x: max_x, max_y: max_y}
  end

  def is_valid_coordinate?(field, coordinate, pid) do
    list_robots = Xerpa.DynamicSupervisor.list_robots(pid)

    coordinated_within_the_limits?(field, coordinate) and
      not exists_robot_in_this_coordinate?(list_robots, coordinate)
  end

  # Privates

  defp validate_max_value!(max_value) do
    case max_value > 0 do
      true -> :ok
      false -> raise(Xerpa.Field.InvalidValue, message: "max value should be greater than zero")
    end
  end

  defp coordinated_within_the_limits?(%Field{max_x: max_x, max_y: max_y}, %Coordinate{x: x, y: y}) do
    max_x >= x and max_y >= y and x >= 0 and y >= 0
  end

  defp exists_robot_in_this_coordinate?(list_robots, %Coordinate{x: target_x, y: target_y}) do
    Enum.any?(list_robots, fn %{coordinate: %Coordinate{x: robot_x, y: robot_y}} ->
      target_x == robot_x and target_y == robot_y
    end)
  end
end
