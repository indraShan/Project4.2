defmodule CryptoCoin.Listener do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(
      __MODULE__,
      :ok
    )
  end

  def handle_cast({:start_listening, simulator}, state) do
    spawn(start_listening_simulator(simulator, 50))
    {:noreply, state}
  end

  def handle_cast({:network_state, chain_length, num_nodes, num_wallets, wallets_amount_map, block_chain_length_time_map, block_chain_length_nounce_value_map}, state) do
    IO.puts "chain_length = #{chain_length}"
    {:noreply, state}
  end

  # def handle_cast({:network_state, chain_length}, state) do
  #   IO.puts "chain_length = #{chain_length}"
  #   {:noreply, state}
  # end

  def init(_opts) do
    state = %{}
    {:ok, state}
  end

  defp start_listening_simulator(_pid, count) when count < 1 do
    nil
  end

  defp start_listening_simulator(pid, count) do
    CryptoCoin.Simulator.get_simulator_stats(pid)
    :timer.sleep(5000)
    start_listening_simulator(pid, count - 1)
  end
end