defmodule Insights.Discussions.Discussion do
  use Ecto.Schema
  import Ecto.Changeset


  schema "discussions" do
    field :absent, :string
    field :present, :string
    field :meeting, :id
    field :issue, :id

    timestamps()
  end

  @doc false
  def changeset(discussion, attrs) do
    discussion
    |> cast(attrs, [:present, :absent])
    |> validate_required([:present, :absent])
  end
end
