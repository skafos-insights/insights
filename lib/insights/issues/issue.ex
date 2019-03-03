defmodule Insights.Issues.Issue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "issues" do
    field :appropriations, :integer
    field :description, :string
    field :identifier, :string
    field :importance, :float
    field :status, :string
    field :urls, :string
    many_to_many :meetings, Insights.Meetings.Meeting, join_through: "issues_to_meetings"

    timestamps()
  end

  @doc false
  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [:description, :identifier, :importance, :appropriations, :status, :urls])
    |> validate_required([:description, :identifier, :importance, :appropriations, :status, :urls])
  end
end
