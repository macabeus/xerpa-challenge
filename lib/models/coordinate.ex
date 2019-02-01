defmodule Xerpa.Coordinate do
  alias Xerpa.Coordinate

  @enforce_keys [:x, :y, :direction]
  defstruct [:x, :y, :direction]

  @valid_directions [:north, :south, :east, :west]

  def new(x, y, direction) do
    validate_direction!(direction)
    %Coordinate{x: x, y: y, direction: direction}
  end

  # Privates

  defp validate_direction!(direction) do
    case Enum.member?(@valid_directions, direction) do
      true -> :ok
      false -> raise(Xerpa.Coordinate.InvalidValue, message: "invalid value for direction")
    end
  end
end
