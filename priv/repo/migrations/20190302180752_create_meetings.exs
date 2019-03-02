defmodule Insights.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :date, :date
      add :summary_url, :string
      add :detail_url, :string
      add :body, :string

      timestamps()
    end

  end
end
