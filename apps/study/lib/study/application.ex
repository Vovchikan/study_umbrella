defmodule Study.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Study.Repo,
      {DNSCluster, query: Application.get_env(:study, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Study.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Study.Finch}
      # Start a worker by calling: Study.Worker.start_link(arg)
      # {Study.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Study.Supervisor)
  end
end
