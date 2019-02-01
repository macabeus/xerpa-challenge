defmodule XerpaTest.Robot do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate
  alias Xerpa.Robot

  setup do
    blank_coordinate = Coordinate.new(0, 0, :north)

    {:ok, _pid} = Robot.start_link(name: :robot_1, coordinate: blank_coordinate)
    {:ok, _pid} = Robot.start_link(name: :robot_2, coordinate: blank_coordinate)
    {:ok, _pid} = Robot.start_link(name: :robot_3, coordinate: blank_coordinate)

    :ok
  end

  test "should move forward" do
    {:ok, %{coordinate: coordinate}} = Robot.move(:robot_1, :forward)

    assert %Coordinate{x: 0, y: 1, direction: :north} == coordinate
  end

  test "should spin left" do
    {:ok, %{coordinate: coordinate}} = Robot.move(:robot_1, :spin_left)

    assert %Coordinate{x: 0, y: 0, direction: :west} == coordinate
  end

  test "should spin right" do
    {:ok, %{coordinate: coordinate}} = Robot.move(:robot_1, :spin_right)

    assert %Coordinate{x: 0, y: 0, direction: :east} == coordinate
  end
end
