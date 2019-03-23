defmodule InsightsWeb.PageController do
  use InsightsWeb, :controller

  alias Insights.Issues

  def index(conn, _params) do
    issues = Issues.list_issues() |> Insights.Repo.preload(:discussions)

    render(conn, "index.html", issues: issues)
  end
end
