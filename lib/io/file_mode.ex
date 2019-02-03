defmodule Xerpa.FileMode do
  alias Xerpa.Input
  alias Xerpa.Output
  alias Xerpa.Robot

  def start(filepath) do
    Xerpa.DynamicSupervisor.start_link()

    [field_input | input_tail] =
      File.stream!(filepath)
      |> Enum.to_list()

    try do
      field = Input.read_field(field_input)
      robot_input(field, 1, input_tail)
    rescue
      e in Xerpa.InvalidUserInput ->
        IO.puts("Error on line 1: #{e.message}")
        IO.puts("Current value: #{field_input}")
    end
  end

  defp robot_input(field, count, [coordinate_input, actions_input | input_tail]) do
    try do
      coordinate = Input.read_coordinate(coordinate_input)
      actions = Input.read_robot_actions(actions_input)
      robot_id = String.to_atom("robot_#{count}")

      {:ok, _pid} = Xerpa.DynamicSupervisor.start_child(robot_id, coordinate, field)
      Enum.each(actions, &Robot.move(robot_id, &1))

      Output.say_robot(robot_id)

      robot_input(field, count + 1, input_tail)
    rescue
      e in Xerpa.InvalidUserInput ->
        case e.message =~ "'coordinate'" do
          true ->
            IO.puts("Error on line #{count * 2}: #{e.message}")
            IO.puts("Current value: #{coordinate_input}")

          false ->
            IO.puts("Error on line #{count * 2 + 1}: #{e.message}")
            IO.puts("Current value: #{actions_input}")
        end
    end
  end

  defp robot_input(_field, count, [_coordinate_input]) do
    IO.puts("Error on line #{count * 2}: don't have the robot actions on next line")
  end

  defp robot_input(field, _count, []) do
    Output.say_field(field)
  end
end
