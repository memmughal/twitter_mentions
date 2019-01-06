defmodule TwitterMentions.MixProject do
  use Mix.Project

  def project do
    [
      app: :twitter_mentions,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :extwitter],
      mod: {TwitterMentions.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:oauther, "~> 1.1"},
      {:extwitter, "~> 0.8"}
    ]
  end

  defp aliases do
    [test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
