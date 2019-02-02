defmodule Xerpa.MixProject do
  use Mix.Project

  def project do
    [
      app: :xerpa,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      aliases: [test: "test --no-start"],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Xerpa, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
