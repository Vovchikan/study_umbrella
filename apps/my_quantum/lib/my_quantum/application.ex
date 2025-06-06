defmodule MyQuantum.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyQuantum.Scheduler
    ]

    opts = [strategy: :one_for_one, name: MyQuantum.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
