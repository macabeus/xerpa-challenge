defmodule Xerpa.Robot do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  # Callbacks

  def init(nil) do
    {:ok, nil}
  end
end
