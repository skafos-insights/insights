defmodule InsightsWeb.DiscussionController do
  use InsightsWeb, :controller

  alias Insights.Discussions
  alias Insights.Discussions.Discussion

  def index(conn, _params) do
    discussions =
      Discussions.list_discussions()
      |> Insights.Repo.preload(:issue)
      |> Insights.Repo.preload(:meeting)

    render(conn, "index.html", discussions: discussions)
  end

  def new(conn, _params) do
    changeset = Discussions.change_discussion(%Discussion{})
    render(conn, "new.html", changeset: changeset)
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &InsightsWeb.ErrorHelpers.translate_error/1)
  end

  def create(conn, %{"discussion" => discussion_params}) do
    m = Discussions.create_discussion(discussion_params)

    case m do
      {:ok, discussion} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.api_discussion_path(conn, :show, discussion))
        |> render("show.json", discussion: discussion)

      {:error, %Ecto.Changeset{} = changeset} ->
        json(conn |> put_status(500), %{errors: translate_errors(changeset)})
    end
  end

  def show(conn, %{"id" => id}) do
    discussion =
      Discussions.get_discussion!(id)
      |> Insights.Repo.preload(:issue)
      |> Insights.Repo.preload(:meeting)

    html = Phoenix.HTML.Format.text_to_html(discussion.body)

    IO.inspect(discussion)

    render(conn, "show.html", discussion: discussion, html: html)
  end

  def edit(conn, %{"id" => id}) do
    discussion = Discussions.get_discussion!(id)
    changeset = Discussions.change_discussion(discussion)
    render(conn, "edit.html", discussion: discussion, changeset: changeset)
  end

  def update(conn, %{"id" => id, "discussion" => discussion_params}) do
    discussion = Discussions.get_discussion!(id)

    case Discussions.update_discussion(discussion, discussion_params) do
      {:ok, discussion} ->
        conn
        |> put_flash(:info, "Discussion updated successfully.")
        |> redirect(to: Routes.discussion_path(conn, :show, discussion))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", discussion: discussion, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    discussion = Discussions.get_discussion!(id)
    {:ok, _discussion} = Discussions.delete_discussion(discussion)

    conn
    |> put_flash(:info, "Discussion deleted successfully.")
    |> redirect(to: Routes.discussion_path(conn, :index))
  end
end
