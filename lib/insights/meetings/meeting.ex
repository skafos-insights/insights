defmodule Insights.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field :title, :string
    field :body, :string
    field :date, :date
    field :detail_url, :string
    field :summary_url, :string
    many_to_many :issues, Insights.Issues.Issue, join_through: "issues_to_meetings"
    has_many :discussions, Insights.Discussions.Discussion, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :body])
    |> validate_required([:date, :body])
  end
end
