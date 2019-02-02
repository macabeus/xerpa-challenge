defmodule Xerpa do
  use Application
  alias Xerpa.InteractiveMode

  def start(_type, _args) do
    InteractiveMode.start()

    {:ok, self()}
  end
end
