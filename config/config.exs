# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_chain,
  ecto_repos: [ExChain.Repo]

# Configures the endpoint
config :ex_chain, ExChainWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rDccF8f8GU0nbZs3+mVvaGy7mAHL22ZsMC0Oo6y6lWHR3hdy5q6TFsSVDgTbET4G",
  render_errors: [view: ExChainWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExChain.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
