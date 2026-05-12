# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :study, :scopes,
  user: [
    default: true,
    module: Study.Accounts.Scope,
    assign_key: :current_scope,
    access_path: [:user, :id],
    schema_key: :user_id,
    schema_type: :id,
    schema_table: :users,
    test_data_fixture: Study.AccountsFixtures,
    test_setup_helper: :register_and_log_in_user
  ]


# Configure Mix tasks and generators
config :study,
  ecto_repos: [Study.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :study, Study.Mailer, adapter: Swoosh.Adapters.Local

config :study_web,
  ecto_repos: [Study.Repo],
  generators: [context_app: :study]

# Configures the endpoint
config :study_web, StudyWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: StudyWeb.ErrorHTML, json: StudyWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Study.PubSub,
  live_view: [signing_salt: "G4dT3L1H"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  study_web: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../apps/study_web/assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.12",
  study_web: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("../apps/study_web", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# To check the job
# Change state to :active
# or
# run in shell
# `iex> MyQuantum.Scheduler.activate_job(:tiker)`
config :my_quantum, MyQuantum.Scheduler,
  jobs: [
    tiker: [
      schedule: {:extended, "*/2"},
      task: fn -> IO.puts("double tick") end,
      state: :inactive
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
