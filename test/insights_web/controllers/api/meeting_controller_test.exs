defmodule InsightsWeb.Api.MeetingControllerTest do
  use InsightsWeb.ConnCase

  alias Insights.Meetings
  alias Insights.Meetings.Meeting

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

  def fixture(:meeting) do
    {:ok, meeting} = Meetings.create_meeting(@create_attrs)
    meeting
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all meetings", %{conn: conn} do
      conn = get(conn, Routes.api_meeting_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create meeting" do
    test "renders meeting when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_meeting_path(conn, :create), meeting: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_meeting_path(conn, :show, id))

      assert %{
               "id" => id,
               "body" => "some body",
               "date" => "2010-04-17",
               "detail_url" => "some detail_url",
               "summary_url" => "some summary_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_meeting_path(conn, :create), meeting: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update meeting" do
    setup [:create_meeting]

    test "renders meeting when data is valid", %{conn: conn, meeting: %Meeting{id: id} = meeting} do
      conn = put(conn, Routes.api_meeting_path(conn, :update, meeting), meeting: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_meeting_path(conn, :show, id))

      assert %{
               "id" => id,
               "body" => "some updated body",
               "date" => "2011-05-18",
               "detail_url" => "some updated detail_url",
               "summary_url" => "some updated summary_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, meeting: meeting} do
      conn = put(conn, Routes.api_meeting_path(conn, :update, meeting), meeting: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete meeting" do
    setup [:create_meeting]

    test "deletes chosen meeting", %{conn: conn, meeting: meeting} do
      conn = delete(conn, Routes.api_meeting_path(conn, :delete, meeting))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_meeting_path(conn, :show, meeting))
      end
    end
  end

  defp create_meeting(_) do
    meeting = fixture(:meeting)
    {:ok, meeting: meeting}
  end
end
