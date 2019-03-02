defmodule Insights.Votes.Vote do
  use Ecto.Schema
  import Ecto.Changeset


  schema "votes" do
    field :vote_type, :integer
    field :member_id, :id
    field :discussion, :id

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:vote_type])
    |> validate_required([:vote_type])
  end
end
