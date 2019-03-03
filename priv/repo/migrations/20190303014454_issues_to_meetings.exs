defmodule Insights.Repo.Migrations.IssuesToMeetings do
  use Ecto.Migration

  def change do
    create table(:issues_to_meetings, primary_key: false) do
      add :issue_id, references(:issues, on_delete: :delete_all)
      add :meeting_id, references(:meetings, on_delete: :delete_all)
    end
  end
end
