defmodule FakepostWeb.PageController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts


  def index(conn, _params) do
    post = Accounts.get_posts
    comment = Accounts.get_comment_for_post(9)
    # require IEx
    # IEx.pry()
    render(conn, "index.html", post: post, comment: comment)
  end




end
