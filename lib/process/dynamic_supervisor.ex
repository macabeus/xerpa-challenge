defmodule Xerpa.DynamicSupervisor do
  use DynamicSupervisor

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_child(name, coordinate, field) do
    spec = {Xerpa.Robot, [name: name, coordinate: coordinate, field: field]}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def list_robots(except_pid \\ nil) do
    Supervisor.which_children(__MODULE__)
    |> Enum.map(&elem(&1, 1))
    |> Enum.reject(fn pid -> pid == except_pid end)
    |> Enum.map(&:sys.get_state(&1))
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
