defmodule InsightsWeb.PageController do
  use InsightsWeb, :controller

  alias Insights.Issues
  alias Insights.Discussions
  alias Insights.Meetings
  alias Insights.Repo

  def index(conn, _params) do
    issues = Issues.list_issues() |> Insights.Repo.preload(:discussions)

    render(conn, "index.html", issues: issues)
  end

  def exterminate(conn, _params) do
    Repo.delete_all(Discussions.Discussion)
    Repo.delete_all(Issues.Issue)
    Repo.delete_all(Meetings.Meeting)

    redirect(conn, to: "/")
  end
end
