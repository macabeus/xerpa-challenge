defmodule XerpaTest.DynamicSupervisor do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate
  alias Xerpa.Field

  test "should create robot process" do
    coordinate = Coordinate.new(0, 1, :north)
    field = Field.new(3, 3)

    Xerpa.DynamicSupervisor.start_link()
    assert {:ok, pid} = Xerpa.DynamicSupervisor.start_child(:foo, coordinate, field)

    assert %{
             coordinate: %Coordinate{x: 0, y: 1, direction: :north},
             field: %Field{max_x: 3, max_y: 3}
           } == :sys.get_state(pid)
  end
end
