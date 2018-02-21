defmodule FakepostWeb.PageController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts


  def index(conn, _params) do
    post = Accounts.get_posts
    # require IEx
    # IEx.pry()
    render(conn, "index.html", post: post)
  end

end
