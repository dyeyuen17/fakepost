defmodule FakepostWeb.PageController do
  use FakepostWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
