defmodule InsightsWeb.MeetingControllerTest do
  use InsightsWeb.ConnCase

  alias Insights.Meetings
  alias Insights.Issues

  @create_issue_attrs %{
    appropriations: 42,
    description: "some description",
    identifier: "some identifier",
    importance: 120.5,
    status: "some status",
    urls: "some urls"
  }

  @create_attrs %{
    body: "some body",
    date: ~D[2010-04-17],
    detail_url: "some detail_url",
    summary_url: "some summary_url"
  }
  @update_attrs %{
    body: "some updated body",
    date: ~D[2011-05-18],
    detail_url: "some updated detail_url",
    summary_url: "some updated summary_url"
  }
  @invalid_attrs %{body: nil, date: nil, detail_url: nil, summary_url: nil}
  @import_attrs %{
    meeting: %{
      body: "some body",
      date: ~D[2010-04-17],
      detail_url: "some detail_url",
      summary_url: "some summary_url"
    },
    discussions: [%{absent: "", present: "", issue_id: 1, body: "test"}]
  }

  def fixture(:meeting) do
    {:ok, meeting} = Meetings.create_meeting(@create_attrs)
    meeting
  end

  def fixture(:issue) do
    {:ok, issue} = Issues.create_issue(@create_issue_attrs)
    issue
  end

  describe "index" do
    test "lists all meetings", %{conn: conn} do
      conn = get(conn, Routes.meeting_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Meetings"
    end
  end

  describe "new meeting" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.meeting_path(conn, :new))
      assert html_response(conn, 200) =~ "New Meeting"
    end
  end

  describe "create meeting" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.meeting_path(conn, :create), meeting: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.meeting_path(conn, :show, id)

      conn = get(conn, Routes.meeting_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Meeting"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.meeting_path(conn, :create), meeting: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Meeting"
    end
  end

  describe "import meeting" do
    setup [:create_issue]

    test "returns error when data is invalid", %{conn: conn, issue: issue} do
      invalid = Map.drop(@import_attrs, [:meeting])
      conn = post(conn, Routes.meeting_path(conn, :import), meeting: invalid)

      # assert %{id: id} = redirected_params(conn)
      # assert redirected_to(conn) == Routes.meeting_path(conn, :show, id)

      # conn = get(conn, Routes.meeting_path(conn, :show, id))
      assert json_response(conn, 500)
    end

    test "imports things right", %{conn: conn, issue: issue} do
      import_meeting =
        Map.put(
          @import_attrs,
          :discussions,
          Enum.map(@import_attrs.discussions, fn d -> Map.put(d, :issue_id, issue.id) end)
        )

      IO.inspect("Hello")
      IO.inspect(import_meeting)
      IO.inspect("Hello")

      conn = post(conn, Routes.meeting_path(conn, :import), meeting: import_meeting)
      assert json_response(conn, 200)
    end
  end

  describe "edit meeting" do
    setup [:create_meeting]

    test "renders form for editing chosen meeting", %{conn: conn, meeting: meeting} do
      conn = get(conn, Routes.meeting_path(conn, :edit, meeting))
      assert html_response(conn, 200) =~ "Edit Meeting"
    end
  end

  describe "update meeting" do
    setup [:create_meeting]

    test "redirects when data is valid", %{conn: conn, meeting: meeting} do
      conn = put(conn, Routes.meeting_path(conn, :update, meeting), meeting: @update_attrs)
      assert redirected_to(conn) == Routes.meeting_path(conn, :show, meeting)

      conn = get(conn, Routes.meeting_path(conn, :show, meeting))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, meeting: meeting} do
      conn = put(conn, Routes.meeting_path(conn, :update, meeting), meeting: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Meeting"
    end
  end

  describe "delete meeting" do
    setup [:create_meeting]

    test "deletes chosen meeting", %{conn: conn, meeting: meeting} do
      conn = delete(conn, Routes.meeting_path(conn, :delete, meeting))
      assert redirected_to(conn) == Routes.meeting_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.meeting_path(conn, :show, meeting))
      end
    end
  end

  defp create_meeting(_) do
    meeting = fixture(:meeting)
    {:ok, meeting: meeting}
  end

  defp create_issue(_) do
    issue = fixture(:issue)
    {:ok, issue: issue}
  end
end
