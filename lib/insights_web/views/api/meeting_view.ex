defmodule InsightsWeb.Api.MeetingView do
  use InsightsWeb, :view
  alias InsightsWeb.Api.MeetingView

  def render("index.json", %{meetings: meetings}) do
    %{data: render_many(meetings, MeetingView, "meeting.json")}
  end

  def render("show.json", %{meeting: meeting}) do
    %{data: render_one(meeting, MeetingView, "meeting.json")}
  end

  def render("meeting.json", %{meeting: meeting}) do
    %{id: meeting.id,
      date: meeting.date,
      summary_url: meeting.summary_url,
      detail_url: meeting.detail_url,
      body: meeting.body}
  end
end
