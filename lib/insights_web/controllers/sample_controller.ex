defmodule InsightsWeb.SampleController do
  use InsightsWeb, :controller

  def index(conn, _params) do
    blah = "lkjalfke"
    blah2 = "lkjafelkj"

    render(conn, "index.html", %{:blah => blah, :blah2 => blah2})
  end
end
