defmodule InsightsWeb.IssueController do
  use InsightsWeb, :controller

  alias Insights.Issues
  alias Insights.Issues.Issue

  def index(conn, _params) do
    issues = Issues.list_issues()
    render(conn, "index.html", issues: issues)
  end

  def new(conn, _params) do
    changeset = Issues.change_issue(%Issue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"issue" => issue_params}) do
    case Issues.create_issue(issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: Routes.issue_path(conn, :show, issue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Issues.get_issue!(id)
    render(conn, "show.html", issue: issue)
  end

  def edit(conn, %{"id" => id}) do
    issue = Issues.get_issue!(id)
    changeset = Issues.change_issue(issue)
    render(conn, "edit.html", issue: issue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Issues.get_issue!(id)

    case Issues.update_issue(issue, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: Routes.issue_path(conn, :show, issue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", issue: issue, changeset: changeset)

      {:error, %Ecto.Changeset{} = changeset} ->
        json(conn |> put_status(500), %{errors: translate_errors(changeset)})
    end
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &InsightsWeb.ErrorHelpers.translate_error/1)
  end

  def delete(conn, %{"id" => id}) do
    issue = Issues.get_issue!(id)
    {:ok, _issue} = Issues.delete_issue(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: Routes.issue_path(conn, :index))
  end
end
