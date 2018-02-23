defmodule FakepostWeb.PageController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts
  alias Fakepost.Accounts.Comment
  alias Fakepost.Accounts.Post


  def index(conn, _params) do
    post = Accounts.get_posts
    comment = Accounts.get_comments
    changeset = Comment.changeset(%Comment{}, %{})
    post_changeset = Post.changeset(%Post{}, %{})

    render(conn, "index.html", post: post, comment: comment, changeset: changeset, post_changeset: post_changeset)
  end


  def new_comment(conn, %{"post_id" => post_id, "comments" => comments_params}) do
    post_id_int = post_id |> String.to_integer
  	Accounts.create_comment(comments_params, conn.assigns.current_user.id, post_id_int)
    |> comment_response(conn)
  end

  defp comment_response({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: page_path(conn, :index))
  end

  defp comment_response({:ok, _user}, conn) do
    conn
    |> redirect(to: page_path(conn, :index))
  end


end
