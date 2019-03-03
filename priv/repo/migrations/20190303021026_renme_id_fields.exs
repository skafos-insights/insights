defmodule Insights.Repo.Migrations.RenmeIdFields do
  use Ecto.Migration

  def change do
    rename table(:discussions), :meeting, to: :meeting_id
    rename table(:discussions), :issue, to: :issue_id
    rename table(:votes), :discussion, to: :discussion_id
    # rename table(:votes), :issue, to: :issue_id
  end
end
