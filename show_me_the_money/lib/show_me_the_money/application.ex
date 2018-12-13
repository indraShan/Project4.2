defmodule ShowMeTheMoney.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(ShowMeTheMoney.Repo, []),
      # Start the endpoint when the application starts
      supervisor(ShowMeTheMoneyWeb.Endpoint, []),
      # Start your own worker by calling: ShowMeTheMoney.Worker.start_link(arg1, arg2, arg3)
      # worker(ShowMeTheMoney.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShowMeTheMoney.Supervisor]
    Supervisor.start_link(children, opts)
    {:ok, listener} = CryptoCoin.Listener.start_link(nil)
    {:ok, simulator} = CryptoCoin.Simulator.start_link(nil)

    # IO.inspect listener
    CryptoCoin.Simulator.set_state_change_listener(simulator, listener)
    GenServer.cast(listener, {:start_listening, simulator})
    # CryptoCoin.Simulator.get_simulator_stats(simulator)
    {:ok, self()}
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShowMeTheMoneyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
