defmodule Xerpa.Field do
  alias Xerpa.Coordinate
  alias Xerpa.Field

  @enforce_keys [:max_x, :max_y]
  defstruct [:max_x, :max_y]

  def new(max_x, max_y) do
    validate_max_value!(max_x)
    validate_max_value!(max_y)

    %Field{max_x: max_x, max_y: max_y}
  end

  def is_valid_coordinate(%Field{max_x: max_x, max_y: max_y}, %Coordinate{x: x, y: y}) do
    max_x >= x and max_y >= y and x >= 0 and y >= 0
  end

  # Privates

  defp validate_max_value!(max_value) do
    case max_value > 0 do
      true -> :ok
      false -> raise(Xerpa.Field.InvalidValue, message: "max value should be greater than zero")
    end
  end
end
