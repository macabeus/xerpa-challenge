defmodule Xerpa.Input do
  alias Xerpa.Coordinate
  alias Xerpa.Field

  @direction_input_map %{"N" => :north, "S" => :south, "E" => :east, "W" => :west}
  @actions_input_map %{"M" => :forward, "L" => :spin_left, "R" => :spin_right}

  def read_field(input_line) do
    regex_result = Regex.run(~r/(\d+)\s+(\d+)/, input_line)

    if regex_result == nil do
      raise(Xerpa.InvalidUserInput, "the input for 'field' should be two numbers, like '11 2'")
    end

    [_, max_x_raw, max_y_raw] = regex_result

    max_x = String.to_integer(max_x_raw)
    max_y = String.to_integer(max_y_raw)

    Field.new(max_x, max_y)
  end

  def read_coordinate(input_line) do
    regex_result = Regex.run(~r/(\d+)\s+(\d+)\s+(\w)/, input_line)

    if regex_result == nil do
      raise(
        Xerpa.InvalidUserInput,
        "the input for 'coordinate' should be two numbers and one letter N | S | E | W, like '3 1 E'"
      )
    end

    [_, x_raw, y_raw, direction_raw] = regex_result

    x = String.to_integer(x_raw)
    y = String.to_integer(y_raw)
    direction = @direction_input_map[direction_raw]

    Coordinate.new(x, y, direction)
  end

  def read_robot_actions(input_line) do
    regex_result = Regex.run(~r/[^MLR\n]/, input_line)

    if regex_result != nil do
      raise(
        Xerpa.InvalidUserInput,
        "the input for 'actions' should be a list of M | L | R, like 'MLMRRM'"
      )
    end

    Regex.scan(~r/[MLR]/, input_line)
    |> List.flatten()
    |> Enum.map(&Map.fetch!(@actions_input_map, &1))
  end
end
