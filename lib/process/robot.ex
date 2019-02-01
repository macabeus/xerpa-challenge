defmodule Xerpa.Robot do
  use GenServer

  def start_link(name: name, coordinate: coordinate) do
    init_arg = %{
      coordinate: coordinate
    }

    GenServer.start_link(__MODULE__, init_arg, name: name)
  end

  # Callbacks

  def init(args) do
    {:ok, args}
  end
end
