# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :board,
  ecto_repos: [Board.Repo]

# Configures the endpoint
config :board, BoardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SNQgQwUDp3sRgY4KrUTkCv0YSn7DMyo/QwAdoQmGoGsV+zTZK0+BtDfAHc3JmRiU",
  render_errors: [view: BoardWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Board.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "QcyA2aC+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
