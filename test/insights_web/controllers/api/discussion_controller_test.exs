defmodule InsightsWeb.Api.DiscussionControllerTest do
  use InsightsWeb.ConnCase

  alias Insights.Discussions
  alias Insights.Discussions.Discussion

  @create_attrs %{
    absent: "some absent",
    body: "some body",
    present: "some present"
  }
  @update_attrs %{
    absent: "some updated absent",
    body: "some updated body",
    present: "some updated present"
  }
  @invalid_attrs %{absent: nil, body: nil, present: nil}

  def fixture(:discussion) do
    {:ok, discussion} = Discussions.create_discussion(@create_attrs)
    discussion
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all discussions", %{conn: conn} do
      conn = get(conn, Routes.api_discussion_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create discussion" do
    test "renders discussion when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_discussion_path(conn, :create), discussion: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_discussion_path(conn, :show, id))

      assert %{
               "id" => id,
               "absent" => "some absent",
               "body" => "some body",
               "present" => "some present"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_discussion_path(conn, :create), discussion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update discussion" do
    setup [:create_discussion]

    test "renders discussion when data is valid", %{conn: conn, discussion: %Discussion{id: id} = discussion} do
      conn = put(conn, Routes.api_discussion_path(conn, :update, discussion), discussion: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_discussion_path(conn, :show, id))

      assert %{
               "id" => id,
               "absent" => "some updated absent",
               "body" => "some updated body",
               "present" => "some updated present"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, discussion: discussion} do
      conn = put(conn, Routes.api_discussion_path(conn, :update, discussion), discussion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete discussion" do
    setup [:create_discussion]

    test "deletes chosen discussion", %{conn: conn, discussion: discussion} do
      conn = delete(conn, Routes.api_discussion_path(conn, :delete, discussion))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_discussion_path(conn, :show, discussion))
      end
    end
  end

  defp create_discussion(_) do
    discussion = fixture(:discussion)
    {:ok, discussion: discussion}
  end
end
