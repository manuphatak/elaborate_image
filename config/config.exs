# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elaborate_image, ElaborateImageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pIInPjukGaGGmvvyd+rJCOetMcnnaiDES4r7BmWlG1EyvnhEhMWFMyfxIgyi8ZN3",
  render_errors: [view: ElaborateImageWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ElaborateImage.PubSub, adapter: Phoenix.PubSub.PG2]

config :elaborate_image, :generators, migration: false, schema: false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sentry,
  dsn: "https://public:secret@app.getsentry.com/1",
  included_environments: [:prod],
  environment_name: Mix.env()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
