defmodule Insights.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add(:date, :date)
      add(:agenda_url, :string)
      add(:minutes_url, :string)
      add(:body, :string)

      timestamps()
    end
  end
end
