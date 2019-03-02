defmodule InsightsWeb.VoteController do
  use InsightsWeb, :controller

  alias Insights.Votes
  alias Insights.Votes.Vote

  def index(conn, _params) do
    votes = Votes.list_votes()
    render(conn, "index.html", votes: votes)
  end

  def new(conn, _params) do
    changeset = Votes.change_vote(%Vote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vote" => vote_params}) do
    case Votes.create_vote(vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote created successfully.")
        |> redirect(to: Routes.vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vote = Votes.get_vote!(id)
    render(conn, "show.html", vote: vote)
  end

  def edit(conn, %{"id" => id}) do
    vote = Votes.get_vote!(id)
    changeset = Votes.change_vote(vote)
    render(conn, "edit.html", vote: vote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vote" => vote_params}) do
    vote = Votes.get_vote!(id)

    case Votes.update_vote(vote, vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote updated successfully.")
        |> redirect(to: Routes.vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vote: vote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote = Votes.get_vote!(id)
    {:ok, _vote} = Votes.delete_vote(vote)

    conn
    |> put_flash(:info, "Vote deleted successfully.")
    |> redirect(to: Routes.vote_path(conn, :index))
  end
end
