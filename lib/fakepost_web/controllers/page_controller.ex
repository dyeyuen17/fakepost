defmodule FakepostWeb.PageController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts


  def index(conn, _params) do
    post = Accounts.get_posts
    render(conn, "index.html", post: post)
  end

end
