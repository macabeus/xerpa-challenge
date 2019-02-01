defmodule Xerpa.Coordinate do
  alias Xerpa.Coordinate

  @enforce_keys [:x, :y, :direction]
  defstruct [:x, :y, :direction]

  @valid_directions [:north, :south, :east, :west]

  def new(x, y, direction) do
    validate_direction!(direction)
    %Coordinate{x: x, y: y, direction: direction}
  end

  def move_forward(%Coordinate{x: x, y: y, direction: direction} = coordinate) do
    case direction do
      :north ->
        %{coordinate | y: y + 1}

      :south ->
        %{coordinate | y: y - 1}

      :east ->
        %{coordinate | x: x + 1}

      :west ->
        %{coordinate | x: x - 1}
    end
  end

  def spin_left(%Coordinate{direction: direction} = coordinate) do
    case direction do
      :north ->
        %{coordinate | direction: :west}

      :south ->
        %{coordinate | direction: :east}

      :east ->
        %{coordinate | direction: :north}

      :west ->
        %{coordinate | direction: :south}
    end
  end

  def spin_right(%Coordinate{direction: direction} = coordinate) do
    case direction do
      :north ->
        %{coordinate | direction: :east}

      :south ->
        %{coordinate | direction: :west}

      :east ->
        %{coordinate | direction: :south}

      :west ->
        %{coordinate | direction: :north}
    end
  end

  # Privates

  defp validate_direction!(direction) do
    case Enum.member?(@valid_directions, direction) do
      true -> :ok
      false -> raise(Xerpa.Coordinate.InvalidValue, message: "invalid value for direction")
    end
  end
end
