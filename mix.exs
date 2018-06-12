defmodule Gultalis.MixProject do
  use Mix.Project

  def project do
    [
      app: :gultalis,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:logger, :slack, :httpoison],
      mod: {Gultalis, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:slack, "~> 0.13.0"},
      {:floki, "~> 0.20.2"},
      {:google_api_sheets, "~> 0.0.2"},
      {:goth, "~> 0.7.0"}
    ]
  end
end
