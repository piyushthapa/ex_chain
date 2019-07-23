defmodule ExChain.Blockchain.Worker do
  use GenServer

  alias ExChain.Blockchain
  alias ExChain.Blockchain.Block

  @moduledoc """
    Handles Blockchain state & interaction
  """

  # -----------------------
  #      CLIENT API
  # -----------------------

  @doc """
    Initiate with genesis block
  """
  def start_link do
    GenServer.start_link(__MODULE__, [Blockchain.genesis_block()], [])
  end

  def handle_call({:fetch_blocks}, chains) do
    {:reply, chains}
  end

  def handle_cast({:add_chain, data}, chains) do
    previous_block = List.last(chains)
    case Block.mine_block(previous_block, data) do
      %Block{} = new_block ->
        {:noreply, chains ++ new_block}

      _ ->
        {:noreply, chains}
    end
  end



  def add_block(data) do
    GenServer.cast(self(), {:add_chain, data})
  end

  def fetch_block() do
    GenServer.call(self(), {:fetch_blocks})
  end
end
