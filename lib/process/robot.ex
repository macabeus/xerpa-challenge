defmodule Xerpa.Robot do
  use GenServer
  alias Xerpa.Coordinate
  alias Xerpa.Field

  def start_link(name: name, coordinate: coordinate, field: field) do
    init_arg = %{
      coordinate: coordinate,
      field: field
    }

    GenServer.start_link(__MODULE__, init_arg, name: name)
  end

  # Public

  def move(name, action) do
    GenServer.call(name, action)
  end

  # Callbacks

  def init(args) do
    {:ok, args}
  end

  def handle_call(:forward, _from, %{coordinate: coordinate, field: field} = state) do
    new_coordinate = Coordinate.move_forward(coordinate)

    case Field.is_valid_coordinate(field, new_coordinate) do
      true ->
        new_state = %{state | coordinate: new_coordinate}

        {:reply, {:ok, new_state}, new_state}

      false ->
        {:reply, {:error, :invalid_position}, state}
    end
  end

  def handle_call(:spin_left, _from, %{coordinate: coordinate} = state) do
    new_coordinate = Coordinate.spin_left(coordinate)
    new_state = %{state | coordinate: new_coordinate}

    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call(:spin_right, _from, %{coordinate: coordinate} = state) do
    new_coordinate = Coordinate.spin_right(coordinate)
    new_state = %{state | coordinate: new_coordinate}

    {:reply, {:ok, new_state}, new_state}
  end
end
