defmodule Insights.Repo.Migrations.TimestampDefaultsUpdated do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      modify :updated_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
