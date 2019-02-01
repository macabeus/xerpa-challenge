defmodule XerpaTest.DynamicSupervisor do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate

  test "should create robot process" do
    coordinate = Coordinate.new(0, 1, :north)

    Xerpa.DynamicSupervisor.start_link()
    assert {:ok, pid} = Xerpa.DynamicSupervisor.start_child(:foo, coordinate)

    assert %{
             coordinate: %Coordinate{x: 0, y: 1, direction: :north}
           } == :sys.get_state(pid)
  end
end
