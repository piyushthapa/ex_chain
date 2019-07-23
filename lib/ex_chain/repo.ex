defmodule ExChain.Repo do
  use Ecto.Repo,
    otp_app: :ex_chain,
    adapter: Ecto.Adapters.Postgres
end
