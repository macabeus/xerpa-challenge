defmodule Mix.Tasks.ReadFile do
  use Mix.Task
  alias Xerpa.FileMode

  @impl Mix.Task
  def run([]) do
    IO.puts("Error: Should pass a file as argument")
  end

  @impl Mix.Task
  def run([filepath | _tail]) do
    case File.exists?(filepath) do
      true -> FileMode.start(filepath)
      false -> IO.puts("Error: doesn't exists a file called #{filepath}")
    end
  end
end
