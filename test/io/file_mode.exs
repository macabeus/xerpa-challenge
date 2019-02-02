defmodule XerpaTest.FileMode do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias Xerpa.FileMode

  setup_all do
    valid_input =
      capture_io(fn ->
        FileMode.start("test/helpers/valid_input.txt")
      end)

    invalid_field_input =
      capture_io(fn ->
        FileMode.start("test/helpers/invalid_field_input.txt")
      end)

    invalid_coordinate_input =
      capture_io(fn ->
        FileMode.start("test/helpers/invalid_coordinate_input.txt")
      end)

    invalid_missing_actions_input =
      capture_io(fn ->
        FileMode.start("test/helpers/invalid_missing_actions_input.txt")
      end)

    %{
      valid_input: valid_input,
      invalid_field_input: invalid_field_input,
      invalid_coordinate_input: invalid_coordinate_input,
      invalid_missing_actions_input: invalid_missing_actions_input
    }
  end

  test "should run a valid file input", %{valid_input: valid_input} do
    assert valid_input == "1 3 N\n5 1 E\n"
  end

  test "should fail when try to read a file with invalid field", %{
    invalid_field_input: invalid_field_input
  } do
    assert invalid_field_input ==
             "Error on line 1: the input for 'field' should be two numbers, like '11 2'\nCurrent value: 5\n\n"
  end

  test "should fail when try to read a file with invalid coordinate", %{
    invalid_coordinate_input: invalid_coordinate_input
  } do
    assert invalid_coordinate_input ==
             "Error on line 2: the input for 'coordinate' should be two numbers and one letter N | S | E | W, like '3 1 E'\nCurrent value: 1 2\n\n"
  end

  test "should fail when try to read a file missing robot actions", %{
    invalid_missing_actions_input: invalid_missing_actions_input
  } do
    assert invalid_missing_actions_input ==
             "Error on line 2: don't have the robot actions on next line\n"
  end
end
