defmodule Insights.Repo.Migrations.LongMeetingBody do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      modify :body, :text
    end
  end
end
