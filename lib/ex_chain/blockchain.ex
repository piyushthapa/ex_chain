tdefmodule ExChain.Blockchain do
  alias ExChain.Blockchain.Block

  def genesis_block(), do: Block.genesis()

  def add_chain(chain, data) when is_list(chain) do
    previous_block = get_previous_block(chain)

    chain ++ [Block.mine_block(previous_block, data)]
  end

  def get_previous_block(chain), do: List.last(chain)

  def get_previous_hash(chain) do
    case get_previous_block(chain) do
      %Block{hash: hash} ->
        hash

      _ -> nil
    end
  end

  def is_chain_valid(chain), do: is_chain_valid(chain, true)
  def is_chain_valid([], true), do: true
  def is_chain_valid([_ | []], true), do: true
  def is_chain_valid([previous_block | rest_block], _is_valid) do
    current_block = hd(rest_block)
    sha_operation = Block.get_hash("#{:math.pow(current_block.proof, 2) - :math.pow(previous_block.proof, 2)}")
    cond do
      previous_block.hash != current_block.previous_hash ->
        false

      previous_block.hash != Block.get_hash(previous_block) ->
        false

      String.slice(sha_operation, 0, 4) != "0000" ->
        false

      true ->
        is_chain_valid(rest_block, true)
    end
  end




end
