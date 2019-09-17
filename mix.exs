defmodule CandlestickCollector.MixProject do
  use Mix.Project

  def project do
    [
      app: :candlestick_collector,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CandlestickCollector.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:mongodb, "~> 0.5.1"},
      {:poolboy, "~> 1.5.1"},
      {:distillery, "~> 2.0"},
      {:quantum, "~> 2.3.4"},
      {:timex, "~> 3.6.1"},
      {:jason, "~> 1.0"},
    ]
  end
end
