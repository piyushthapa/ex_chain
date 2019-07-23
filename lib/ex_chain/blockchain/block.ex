defmodule ExChain.Blockchain.Block do
  alias ExChain.Blockchain.Block

  defstruct [:timestamp, :proof, :hash, :previous_hash, :index, :data]

  def genesis() do
    genesis_block =
      %Block{
        timestamp: :os.system_time,
        index: 1,
        proof: 1,
        previous_hash: "0000x",
        data: nil
      }

    %{genesis_block | hash: get_hash(genesis_block)}
  end

  def mine_block(%Block{index: i, hash: previous_hash, proof: proof }, data) do
    new_block =
      %Block{
        timestamp: :os.system_time,
        index: i + 1,
        proof: get_pow(proof, 0, false),
        previous_hash: previous_hash,
        data: data
      }

    %{new_block | hash: get_hash(new_block)}  
  end

  def get_pow(_, proof, true), do: proof
  def get_pow(previous_proof, proof, false) do
    new_proof = proof + 1
    new_sha_operation = get_hash("#{:math.pow(new_proof, 2) - :math.pow(previous_proof, 2)}")
    get_pow(previous_proof, new_proof, String.slice(new_sha_operation, 0, 4) == "0000")
  end

  def get_hash(%Block{timestamp: t, index: i, proof: p, previous_hash: p_hash}), do: get_hash("#{t}_#{i}_#{p}_#{p_hash}")
  def get_hash(input_string) when is_binary(input_string) do
    :crypto.hash(:sha256, input_string)
    |> Base.encode16()
    |> String.downcase()
  end
end
