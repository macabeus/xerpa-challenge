defmodule Xerpa.InteractiveMode do
  alias Xerpa.Input
  alias Xerpa.Output
  alias Xerpa.Robot

  def start() do
    Xerpa.DynamicSupervisor.start_link()

    try do
      field =
        IO.gets("Field: ")
        |> Input.read_field()

      coordinate =
        IO.gets("Coordinate: ")
        |> Input.read_coordinate()

      actions =
        IO.gets("Actions: ")
        |> Input.read_robot_actions()

      {:ok, _pid} = Xerpa.DynamicSupervisor.start_child(:robot, coordinate, field)
      Enum.each(actions, &Robot.move(:robot, &1))

      Output.say_robot(:robot)
    rescue
      e in Xerpa.InvalidUserInput -> IO.puts(e.message)
    end
  end
end
