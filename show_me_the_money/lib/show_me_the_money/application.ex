defmodule ShowMeTheMoney.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      ShowMeTheMoneyWeb.Endpoint
      # Starts a worker by calling: ShowMeTheMoney.Worker.start_link(arg)
      # {CryptoCoin.Simulator, nil}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShowMeTheMoney.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShowMeTheMoneyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
