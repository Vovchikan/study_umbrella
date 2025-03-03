import Config

config :my_quantum, MyQuantum.Scheduler,
  jobs: [
    tiker: [
      schedule: {:extended, "*/2"},
      task: fn -> IO.puts("double tick") end
    ]
  ]
#import_config "#{config_env()}.exs"
