defmodule XerpaTest.Robot do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate
  alias Xerpa.Field
  alias Xerpa.Robot

  setup do
    Xerpa.DynamicSupervisor.start_link()

    blank_coordinate = Coordinate.new(0, 0, :north)
    field = Field.new(2, 2)

    {:ok, _pid} = Robot.start_link(name: :robot_1, coordinate: blank_coordinate, field: field)
    {:ok, _pid} = Robot.start_link(name: :robot_2, coordinate: blank_coordinate, field: field)
    {:ok, _pid} = Robot.start_link(name: :robot_3, coordinate: blank_coordinate, field: field)
    {:ok, _pid} = Robot.start_link(name: :robot_4, coordinate: blank_coordinate, field: field)

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

  test "should not exceed the limits of the field" do
    {:ok, _} = Robot.move(:robot_4, :forward)
    {:ok, _} = Robot.move(:robot_4, :forward)
    {:error, message} = Robot.move(:robot_4, :forward)

    assert :invalid_position == message
  end
end
