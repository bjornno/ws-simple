defmodule WsElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ws_elixir,
      version: "0.1.0",
      elixir: ">= 0.13.3",
      deps: deps
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:ranch, :crypto, :cowboy, :gproc],
      mod: {WebSocketServer, []},
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0.2"},
      {:gproc, github: "esl/gproc"},
    ]
  end
end

 
