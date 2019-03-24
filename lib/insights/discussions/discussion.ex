defmodule Insights.Discussions.Discussion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discussions" do
    field(:absent, :string)
    field(:present, :string)
    field(:body, :string)
    field(:votes, :string)
    field(:type, :string)
    field(:discussion_type, :string)
    field(:dollar_amount, :string)
    field(:status, :string)
    belongs_to(:meeting, Insights.Meetings.Meeting, foreign_key: :meeting_id)
    belongs_to(:issue, Insights.Issues.Issue, foreign_key: :issue_id)

    timestamps()
  end

  def changeset(discussion, attrs) do
    discussion
    |> cast(attrs, [:body, :status, :votes, :meeting_id, :issue_id, :discussion_type, :type])
    |> validate_required([:body, :meeting_id, :issue_id])
  end
end
