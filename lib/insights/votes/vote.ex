defmodule Insights.Votes.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :vote_type, :integer
    belongs_to :member, Insights.Members.Member, foreign_key: :member_id
    # belongs_to :issue, Insights.Issues.Issue, foreign_key: :issue_id

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:vote_type])
    |> validate_required([:vote_type])
  end
end
