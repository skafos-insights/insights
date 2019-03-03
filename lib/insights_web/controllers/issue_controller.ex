defmodule InsightsWeb.IssueController do
  use InsightsWeb, :controller
  import Ecto.Query

  alias Insights.Issues
  alias Insights.Issues.Issue

  def index(conn, _params) do
    issues = Issues.list_issues()
    render(conn, "index.html", issues: issues)
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
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

    meetings = Insights.Meetings.list_meetings()

    discussions = Insights.Discussions.list_discussions()

    discussions_filtered =
      discussions
      |> Enum.filter(fn d -> d.issue_id == issue.id end)
      |> Insights.Repo.preload(:meeting)
      |> Insights.Repo.preload(:issue)

    IO.inspect(discussions_filtered)

    render(conn, "show.html", issue: issue, meetings: meetings, discussions: discussions_filtered)
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
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Issues.get_issue!(id)
    {:ok, _issue} = Issues.delete_issue(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: Routes.issue_path(conn, :index))
  end
end
