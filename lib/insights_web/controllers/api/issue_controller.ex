defmodule InsightsWeb.Api.IssueController do
  use InsightsWeb, :controller

  import Protocol
  
  Protocol.derive(Jason.Encoder, Insights.Issues.Issue,
    only: [
      :id,
      :description,
      :identifier,
      :importance,
      :appropriations,
      :status,
      :urls
    ]
  )

  alias Insights.Issues
  alias Insights.Issues.Issue

  action_fallback InsightsWeb.FallbackController

  def index(conn, _params) do
    issues = Issues.list_issues()
    render(conn, "index.json", issues: issues)
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &InsightsWeb.ErrorHelpers.translate_error/1)
  end

  def create(conn, %{"issue" => issue_params}) do
    c = Issues.create_issue(issue_params)

    case c do
      {:ok, issue} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.api_issue_path(conn, :show, issue))
        |> render("show.json", issue: issue)

      {:error, %Ecto.Changeset{} = changeset} ->
        json(conn |> put_status(500), %{errors: translate_errors(changeset)})
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Issues.get_issue!(id)
    render(conn, "show.json", issue: issue)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Issues.get_issue!(id)
      |> Insights.Repo.preload(:discussion)
      |> Insights.Repo.preload(:meetings)

    with {:ok, %Issue{} = issue} <- Issues.update_issue(issue, issue_params) do
      render(conn, "show.json", issue: issue)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Issues.get_issue!(id)

    with {:ok, %Issue{}} <- Issues.delete_issue(issue) do
      send_resp(conn, :no_content, "")
    end
  end
end
