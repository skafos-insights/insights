defmodule InsightsWeb.Api.DiscussionController do
  use InsightsWeb, :controller

  import Protocol

  Protocol.derive(Jason.Encoder, Insights.Discussions.Discussion,
    only: [
      :id,
      :absent,
      :present,
      :body,
      :votes,
      :type,
      :discussion_type,
      :dollar_amount,
      :status,
      :meeting_id,
      :issue_id
    ]
  )

  alias Insights.Discussions
  alias Insights.Discussions.Discussion

  action_fallback(InsightsWeb.FallbackController)

  def index(conn, _params) do
    discussions = Discussions.list_discussions()
    render(conn, "index.json", discussions: discussions)
  end

  def create(conn, %{"discussion" => discussion_params}) do
    with {:ok, discussion} <- Discussions.create_discussion(discussion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_discussion_path(conn, :show, discussion))
      |> json(%{data: discussion})
    end
  end

  def show(conn, %{"id" => id}) do
    discussion = Discussions.get_discussion!(id)
    render(conn, "show.json", discussion: discussion)
  end

  def update(conn, %{"id" => id, "discussion" => discussion_params}) do
    discussion = Discussions.get_discussion!(id)
      |> Insights.Repo.preload(:issue)
      |> Insights.Repo.preload(:meeting)

    with {:ok, %Discussion{} = discussion} <-
           Discussions.update_discussion(discussion, discussion_params) do
      render(conn, "show.json", discussion: discussion)
    end
  end

  def delete(conn, %{"id" => id}) do
    discussion = Discussions.get_discussion!(id)

    with {:ok, %Discussion{}} <- Discussions.delete_discussion(discussion) do
      send_resp(conn, :no_content, "")
    end
  end
end
