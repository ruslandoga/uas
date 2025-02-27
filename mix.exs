defmodule Uas.MixProject do
  use Mix.Project

  def project do
    [
      app: :uas,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.3"},
      {:ua_inspector, github: "plausible/ua_inspector", branch: "sanitize-pre"}
    ]
  end
end
