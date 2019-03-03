defmodule InsightsWeb.Api.DiscussionView do
  use InsightsWeb, :view
  alias InsightsWeb.Api.DiscussionView

  def render("index.json", %{discussions: discussions}) do
    %{data: render_many(discussions, DiscussionView, "discussion.json")}
  end

  def render("show.json", %{discussion: discussion}) do
    %{data: render_one(discussion, DiscussionView, "discussion.json")}
  end

  def render("discussion.json", %{discussion: discussion}) do
    %{id: discussion.id,
      body: discussion.body,
      present: discussion.present,
      absent: discussion.absent}
  end
end
