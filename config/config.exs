# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :to_do_list,
  ecto_repos: [ToDoList.Repo]

# Configures the endpoint
config :to_do_list, ToDoListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jgp4W+35XQj4DymCtz0nYtk/YuBioV+TQI2skNLVy/kPhjZgXhcj5uizQ90l1/PV",
  render_errors: [view: ToDoListWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ToDoList.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
