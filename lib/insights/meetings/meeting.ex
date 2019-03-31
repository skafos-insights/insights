defmodule Insights.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field(:title, :string)
    field(:body, :string)
    field(:date, :date)
    field(:minutes_url, :string)
    field(:agenda_url, :string)
    field(:agenda_html_url, :string)
    field(:media_player, :string)
    field(:duration, :integer)
    field(:granicus_clip_id, :integer)
    field(:granicus_duration, :string)
    field(:granicus_mp4, :string)
    field(:video_file, :string)
    many_to_many(:issues, Insights.Issues.Issue, join_through: "issues_to_meetings")
    has_many(:discussions, Insights.Discussions.Discussion, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :body, :title, :minutes_url, :agenda_url, :agenda_html_url,  :media_player, :duration, :granicus_clip_id, :granicus_duration, :granicus_mp4, :video_file])
    |> validate_required([:date])
  end
end
