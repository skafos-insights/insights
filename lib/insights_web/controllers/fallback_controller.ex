defmodule InsightsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use InsightsWeb, :controller

  def call(conn, {:error, error}) do
    conn
    |> put_status(:not_found)
    |> put_view(InsightsWeb.ErrorView)
    |> render(error)
  end
end
