defmodule Study.Repo do
  use Ecto.Repo,
    otp_app: :study,
    adapter: Ecto.Adapters.Postgres
end
