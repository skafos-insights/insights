defmodule Insights.Repo do
  use Ecto.Repo,
    otp_app: :insights,
    adapter: Ecto.Adapters.Postgres
end
