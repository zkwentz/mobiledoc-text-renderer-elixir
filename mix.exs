defmodule MobileDoc.Text.Mixfile do
  use Mix.Project

  def project do
    [app: :mobiledoc_text,
     version: "0.0.3",
     elixir: "~> 1.0",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev}
    ]
  end

  defp description do
    """
    An HTML renderer for the Mobiledoc format used by the Mobiledoc Kit editor.
    """
  end

  defp package do
    [files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Zach Wentz"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/zkwentz/mobiledoc-text-renderer-elixir"}]
  end
end
