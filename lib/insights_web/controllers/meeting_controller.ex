defmodule InsightsWeb.MeetingController do
  use InsightsWeb, :controller

  alias Insights.Meetings
  alias Insights.Discussions.Discussion
  alias Insights.Meetings.Meeting

  def index(conn, _params) do
    meetings = Meetings.list_meetings()
    render(conn, "index.html", meetings: meetings)
  end

  def new(conn, _params) do
    changeset = Meetings.change_meeting(%Meeting{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meeting" => meeting_params}) do
    case Meetings.create_meeting(meeting_params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Meeting created successfully.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meeting = Meetings.get_meeting!(id)
    html = Phoenix.HTML.Format.text_to_html(meeting.body)
    render(conn, "show.html", meeting: meeting, html: html)
  end

  def edit(conn, %{"id" => id}) do
    meeting = Meetings.get_meeting!(id)
    changeset = Meetings.change_meeting(meeting)
    render(conn, "edit.html", meeting: meeting, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meeting" => meeting_params}) do
    meeting = Meetings.get_meeting!(id)

    case Meetings.update_meeting(meeting, meeting_params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Meeting updated successfully.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", meeting: meeting, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meeting = Meetings.get_meeting!(id)
    {:ok, _meeting} = Meetings.delete_meeting(meeting)

    conn
    |> put_flash(:info, "Meeting deleted successfully.")
    |> redirect(to: Routes.meeting_path(conn, :index))
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &InsightsWeb.ErrorHelpers.translate_error/1)
  end

  def import(conn, %{"meeting" => meeting_params}) do
    meeting = Map.get(meeting_params, "meeting", %{})
    IO.inspect(meeting)
    discussions = Map.get(meeting_params, "discussions", [])
    # Use Ecto.Multi here. They all succeed or fail together.
    result =
      case Meetings.create_meeting(meeting) do
        {:ok, meeting} ->
          Ecto.Multi.new()
          |> Ecto.Multi.insert_all(
            :discussions,
            Discussion,
            Enum.map(discussions, fn discussion ->
              Map.put(discussion, "meeting_id", meeting.id)
              |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
            end)
          )
          |> Insights.Repo.transaction()
          |> case do
            {:ok, discussions} ->
              json(conn, discussions)

            {:error, %Ecto.Changeset{} = changeset} ->
              json(conn |> put_status(500), %{errors: translate_errors(changeset)})
          end

        {:error, %Ecto.Changeset{} = changeset} ->
          json(conn |> put_status(500), %{errors: translate_errors(changeset)})
      end

    result
  end
end
