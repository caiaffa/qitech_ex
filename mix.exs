defmodule QitechEx.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :qitech,
      version: @version,
      description: description(),
      package: package(),
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      name: "QITech",
      source_url: "https://github.com/caiaffa/qitech_ex",
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      docs: docs()
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
      {:tesla, "~> 1.4.0"},
      {:joken, "~> 2.3"},
      {:jason, "~> 1.1"},
      {:hackney, "~> 1.17"},
      {:timex, "~> 3.6"},

      # testing & docs
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.14", only: :test}
    ]
  end

  defp description() do
    "Elixir wrapper for QI Tech API."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["Luís Felipe Caiaffa"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/caiaffa/qitech_ex"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      extras: ["README.md", "LICENSE"],
      source_ref: "v#{@version}",
      source_url: "https://github.com/caiaffa/qitech_ex",
      groups_for_modules: [
        Api: [
          QITech.API.Debt,
          QITech.API.Test
        ],
        JWT: [
          QITech.JWT.Token
        ]
      ]
    ]
  end
end
