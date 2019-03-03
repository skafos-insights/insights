defmodule Insights.Discussions.Discussion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discussions" do
    field :absent, :string
    field :present, :string
    field :body, :string
    field :votes, :string
    belongs_to :meeting, Insights.Meetings.Meeting, foreign_key: :meeting_id
    belongs_to :issue, Insights.Issues.Issue, foreign_key: :issue_id

    timestamps()
  end

  @doc false
  def changeset(discussion, attrs) do
    discussion
    |> cast(attrs, [:body, :meeting_id, :issue_id])
    |> validate_required([:body, :meeting_id, :issue_id])
  end
end
