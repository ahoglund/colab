use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :colab, ColabWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]


# Watch static and templates for browser reloading.
config :colab, ColabWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/colab_web/views/.*(ex)$},
      ~r{lib/colab_web/templates/.*(eex)$},
      ~r{lib/colab_web/live/.*(ex)$}
    ]
  ]

config :colab, ColabWeb.Endpoint,
  live_view: [
    signing_salt: "uWzX7ur0bafrmJBt3cGfV4GY0BTKWwnXumok3BrS4gMwuZBtV7sWSELlDTsm9Tpg"
  ]
# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Configure your database
config :colab, Colab.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "colab_dev",
  hostname: "localhost",
  pool_size: 10
