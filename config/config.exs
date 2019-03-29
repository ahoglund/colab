# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :colab,
  ecto_repos: [Colab.Repo]

# Configures the endpoint
config :colab, ColabWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0+bwG7TtrartUdPIRIn8ICFJt5E3YyQKT8QG/WSN62Pc2AYAdehDJdf/N7czPckR",
  render_errors: [view: ColabWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Colab.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
