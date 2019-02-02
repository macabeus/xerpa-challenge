defmodule XerpaTest.Input do
  use ExUnit.Case, async: true
  alias Xerpa.Coordinate
  alias Xerpa.Field
  alias Xerpa.Input

  test "should create a new field by string" do
    field = Input.read_field("2 3")

    assert %Field{max_x: 2, max_y: 3} == field
  end

  test "should fail when creating a field with invalid string" do
    assert_raise Xerpa.InvalidUserInput,
                 "the input for 'field' should be two numbers, like '11 2'",
                 fn ->
                   Input.read_field("2")
                 end
  end

  test "should create a new coordinate" do
    coordinate = Input.read_coordinate("1 2 S")

    assert %Coordinate{x: 1, y: 2, direction: :south} == coordinate
  end

  test "should fail when creating a coordinate with invalid string" do
    assert_raise Xerpa.InvalidUserInput,
                 "the input for 'coordinate' should be two numbers and one letter N | S | E | W, like '3 1 E'",
                 fn ->
                   Input.read_coordinate("1 2")
                 end
  end

  test "should create a list of robot actions" do
    actions = Input.read_robot_actions("MLR")

    assert [:forward, :spin_left, :spin_right] == actions
  end

  test "should fail when creating a list of robot actions with invalid string" do
    assert_raise Xerpa.InvalidUserInput,
                 "the input for 'actions' should be a list of M | L | R, like 'MLMRRM'",
                 fn ->
                   Input.read_robot_actions("MLinvalidR")
                 end
  end
end
