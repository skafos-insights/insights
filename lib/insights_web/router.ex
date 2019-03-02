defmodule InsightsWeb.Router do
  use InsightsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InsightsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/issues", IssueController
    resources "/members", MemberController
    resources "/discussions", DiscussionController
    resources "/meetings", MeetingController
    resources "/votes", VoteController
  end

  # Other scopes may use custom stacks.
  # scope "/api", InsightsWeb do
  #   pipe_through :api
  # end
end
