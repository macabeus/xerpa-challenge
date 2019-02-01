defmodule XerpaTest.DynamicSupervisor do
  use ExUnit.Case, async: true

  test "should create robot process" do
    Xerpa.DynamicSupervisor.start_link()
    assert {:ok, _pid} = Xerpa.DynamicSupervisor.start_child(:foo)
  end
end
