defmodule Insights.Repo.Migrations.RenameUrls do
  use Ecto.Migration

  def change do
    rename(table(:meetings), :minutes_url, to: :minutes_url)
    rename(table(:meetings), :agenda_url, to: :agenda_url)
  end
end
