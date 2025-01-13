defmodule Blog.MixProject do
  use Mix.Project

  def project do
    [
      app: :vicyap_blog,
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
      {:nimble_publisher, "~> 1.0"},
      {:makeup_elixir, "~> 1.0"},
      {:makeup_erlang, "~> 1.0"},
      {:phoenix_live_view, "~> 1.0"}
    ]
  end
end
