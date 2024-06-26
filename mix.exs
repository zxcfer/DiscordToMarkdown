defmodule Discord2markdown.MixProject do
  use Mix.Project

  def project do
    [
      app: :discord2markdown,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Discord2markdown, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, "~> 0.4"},
      {:git_cli, "~> 0.3.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
    ]
  end
end
