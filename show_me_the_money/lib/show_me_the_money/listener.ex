defmodule CryptoCoin.Listener do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(
      __MODULE__,
      :ok
    )
  end

  def handle_cast({:start_listening, simulator}, state) do
    send(self(), {:query_simlator_state, simulator})
    state = state |> Map.put(:simulator, simulator)
    {:noreply, state |> Map.put(:query_count, 0)}
  end

  def handle_info({:query_simlator_state, simulator}, state) do
    CryptoCoin.Simulator.get_simulator_stats(simulator)

    count = state.query_count
    if (count < 50) do
      Process.send_after(self(), {:query_simlator_state, simulator}, 50)
    end

    {:noreply, state}
  end

  def handle_info({:network_state, chain_length, num_nodes, num_wallets, wallets_amount_map, block_chain_length_time_map, block_chain_length_nounce_value_map}, state) do
    IO.puts "chain_length = #{chain_length}"
    {:noreply, state |> Map.put(:query_count, state.query_count + 1)}
  end

  # def handle_cast({:network_state, chain_length}, state) do
  #   IO.puts "chain_length = #{chain_length}"
  #   {:noreply, state}
  # end

  def init(_opts) do
    state = %{}
    {:ok, state}
  end

  # defp start_listening_simulator(_pid, count) when count < 1 do
  #   nil
  # end
  #
  # defp start_listening_simulator(pid, count) do
  #   CryptoCoin.Simulator.get_simulator_stats(pid)
  #   :timer.sleep(5000)
  #   start_listening_simulator(pid, count - 1)
  # end
end
