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
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, [Blockchain.genesis_block()]}
  end

  def handle_call({:fetch_blocks}, _from, chains) do
    {:reply, chains, chains}
  end

  def handle_cast({:add_chain, data}, chains) do
    previous_block = List.last(chains)
    case Block.mine_block(previous_block, data) do
      %Block{} = new_block ->
        {:noreply, chains ++ [new_block]}

      _ ->
        {:noreply, chains}
    end
  end

  def handle_cast({:replace_chain, incoming_chain}, current_chain) do
    {:noreply, Blockchain.replace_chain(current_chain, incoming_chain)}
  end



  def add_block(data) do
    GenServer.cast(__MODULE__, {:add_chain, data})
  end

  def fetch_block() do
    GenServer.call(__MODULE__, {:fetch_blocks})
  end
end
