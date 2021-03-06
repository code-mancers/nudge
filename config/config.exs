# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nudge,
  ecto_repos: [Nudge.Repo]

# Configures the endpoint
config :nudge, NudgeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NMQQgl6M0lzGyNY1ZjhBiahwwMVCinBhH70eDJsAZo2Hq2oo3OwmFEHZ1262cS58",
  render_errors: [view: NudgeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Nudge.PubSub,
  live_view: [signing_salt: "Y+ea2gw+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
