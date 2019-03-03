defmodule Insights.Repo.Migrations.TimestampDefaults do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      modify :inserted_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
