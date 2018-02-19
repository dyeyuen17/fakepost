# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fakepost,
  ecto_repos: [Fakepost.Repo]

# Configures the endpoint
config :fakepost, FakepostWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Guk8j3OoRgl0UZPZHhlhPc0Mq877yOpNNulV1nXOajPg43+rQvlwAWbHm6OWw9F1",
  render_errors: [view: FakepostWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fakepost.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :fakepost, Fakepost.Accounts.Guardian,
  issuer: "fakepost",
  secret_key: "hue8FKgTW0nl8WwyZc2eWExpqyHLZX3JAvGszytWVD0ZR5kVpt52zOB40Ze9rRuo"

config :fakepost, Fakepost.Accounts.Pipeline,
  module: Fakepost.Accounts.Guardian,
  error_handler: Fakepost.Accounts.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
