defmodule Insights.Repo.Migrations.LongIdentifiers do
  use Ecto.Migration

  def change do
    alter table(:issues) do
      modify(:identifier, :text)
      modify(:status, :text)
    end
  end
end
