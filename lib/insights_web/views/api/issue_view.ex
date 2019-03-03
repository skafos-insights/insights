defmodule InsightsWeb.Api.IssueView do
  use InsightsWeb, :view
  alias InsightsWeb.Api.IssueView

  def render("index.json", %{issues: issues}) do
    %{data: render_many(issues, IssueView, "issue.json")}
  end

  def render("show.json", %{issue: issue}) do
    %{data: render_one(issue, IssueView, "issue.json")}
  end

  def render("issue.json", %{issue: issue}) do
    %{id: issue.id,
      description: issue.description,
      identifier: issue.identifier,
      importance: issue.importance,
      appropriations: issue.appropriations,
      status: issue.status,
      urls: issue.urls}
  end
end
