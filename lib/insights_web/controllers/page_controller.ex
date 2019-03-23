defmodule InsightsWeb.PageController do
  use InsightsWeb, :controller

  alias Insights.Issues

  def index(conn, _params) do
    issues = Issues.list_issues()

    render(conn, "index.html", issues: issues)
  end
end
