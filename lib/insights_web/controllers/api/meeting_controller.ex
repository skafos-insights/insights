defmodule InsightsWeb.Api.MeetingController do
  use InsightsWeb, :controller

  alias Insights.Meetings
  alias Insights.Meetings.Meeting

  action_fallback InsightsWeb.FallbackController

  def index(conn, _params) do
    meetings = Meetings.list_meetings()
    render(conn, "index.json", meetings: meetings)
  end

  def create(conn, %{"meeting" => meeting_params}) do
    with {:ok, %Meeting{} = meeting} <- Meetings.create_meeting(meeting_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_meeting_path(conn, :show, meeting))
      |> render("show.json", meeting: meeting)
    end
  end

  def show(conn, %{"id" => id}) do
    meeting = Meetings.get_meeting!(id)
    render(conn, "show.json", meeting: meeting)
  end

  def update(conn, %{"id" => id, "meeting" => meeting_params}) do
    meeting = Meetings.get_meeting!(id)

    with {:ok, %Meeting{} = meeting} <- Meetings.update_meeting(meeting, meeting_params) do
      render(conn, "show.json", meeting: meeting)
    end
  end

  def delete(conn, %{"id" => id}) do
    meeting = Meetings.get_meeting!(id)

    with {:ok, %Meeting{}} <- Meetings.delete_meeting(meeting) do
      send_resp(conn, :no_content, "")
    end
  end
end
