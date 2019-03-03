defmodule InsightsWeb.Api.IssueControllerTest do
  use InsightsWeb.ConnCase

  alias Insights.Issues
  alias Insights.Issues.Issue

  @create_attrs %{
    appropriations: 42,
    description: "some description",
    identifier: "some identifier",
    importance: 120.5,
    status: "some status",
    urls: "some urls"
  }
  @update_attrs %{
    appropriations: 43,
    description: "some updated description",
    identifier: "some updated identifier",
    importance: 456.7,
    status: "some updated status",
    urls: "some updated urls"
  }
  @invalid_attrs %{appropriations: nil, description: nil, identifier: nil, importance: nil, status: nil, urls: nil}

  def fixture(:issue) do
    {:ok, issue} = Issues.create_issue(@create_attrs)
    issue
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all issues", %{conn: conn} do
      conn = get(conn, Routes.api_issue_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create issue" do
    test "renders issue when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_issue_path(conn, :create), issue: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_issue_path(conn, :show, id))

      assert %{
               "id" => id,
               "appropriations" => 42,
               "description" => "some description",
               "identifier" => "some identifier",
               "importance" => 120.5,
               "status" => "some status",
               "urls" => "some urls"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_issue_path(conn, :create), issue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update issue" do
    setup [:create_issue]

    test "renders issue when data is valid", %{conn: conn, issue: %Issue{id: id} = issue} do
      conn = put(conn, Routes.api_issue_path(conn, :update, issue), issue: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_issue_path(conn, :show, id))

      assert %{
               "id" => id,
               "appropriations" => 43,
               "description" => "some updated description",
               "identifier" => "some updated identifier",
               "importance" => 456.7,
               "status" => "some updated status",
               "urls" => "some updated urls"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, issue: issue} do
      conn = put(conn, Routes.api_issue_path(conn, :update, issue), issue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete issue" do
    setup [:create_issue]

    test "deletes chosen issue", %{conn: conn, issue: issue} do
      conn = delete(conn, Routes.api_issue_path(conn, :delete, issue))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_issue_path(conn, :show, issue))
      end
    end
  end

  defp create_issue(_) do
    issue = fixture(:issue)
    {:ok, issue: issue}
  end
end
