# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vw_stock,
  ecto_repos: [VwStock.Repo]

# Configures the endpoint
config :vw_stock, VwStockWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uw3xgG35WC99xCGNBh2bQQaYM5QFpOHUDjtibwNFFrn2H0DHuB/ER/R98IgHwcjF",
  render_errors: [view: VwStockWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VwStock.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :vw_stock, VwStock.Map,
  api_key: Application.get_env("VW_STOCK_GOOGLE_MAPS_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
