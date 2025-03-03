# MyQuantum

## Installation

Learning [Quantum](https://hexdocs.pm/quantum/readme.html), the package for sheduling jobs in cron style.

Example with job repeating every 2 seconds
```elixir
config :my_quantum, MyQuantum.Scheduler,
  jobs: [
    tiker: [
      schedule: {:extended, "*/2"},
      task: fn -> IO.puts("double tick") end
    ]
  ]
```