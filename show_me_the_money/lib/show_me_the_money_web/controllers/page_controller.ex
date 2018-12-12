defmodule ShowMeTheMoneyWeb.PageController do
  use ShowMeTheMoneyWeb, :controller

  def index(conn, _params) do
    {:ok, simulator} = CryptoCoin.Simulator.start_link(nil)
    CryptoCoin.Simulator.set_state_change_listener(simulator, self())
    render(conn, "index.html", simulator: simulator)
  end

# Does not work
  # def handle_info(
  #       {:network_state, chain_length, number_of_nodes, number_of_wallets, wallets_amount_map,
  #        block_chain_length_time_map, block_chain_length_nounce_value_map},
  #       state
  #     ) do
  #   IO.puts("got the state change thingy")
  #   {:noreply, state}
  # end
end
