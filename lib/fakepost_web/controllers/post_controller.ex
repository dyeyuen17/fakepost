defmodule FakepostWeb.PostController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts.Post
  alias Fakepost.Accounts.User
  alias Fakepost.Repo
  alias Fakepost.Accounts
  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false

  plug :scrub_params, "post" when action in [:create, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, %{"user_id" => user_id}, _current_user) do
    user = User |> Repo.get!(user_id)

    posts =
      user
        |> Ecto.assoc(:posts)
        |> Repo.all
        |> Repo.preload(:user)

    render(conn, "index.html", posts: posts, user: user)
  end

  def show(conn, %{"id" => id}, current_user) do
    user = Accounts.get_user!(current_user.id)
    post = Accounts.get_post!(id)

    render(conn, "show.html", post: post, user: user)
  end

  def new(conn, _params, _current_user) do
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}, current_user) do
    Accounts.create_post(post_params, current_user)
      |> post_response(conn)

  end

  def delete(conn, %{"user_id" => _user_id, "id" => id}, _current_user) do
    post = Accounts.get_post!(id)
    Accounts.delete_post(post)

      conn
      |> put_flash(:info, "Post was deleted successfully")
      |> redirect(to: page_path(conn, :index))

  end

  def edit(conn, %{"user_id" => _user_id, "id" => id}, _current_user) do
    post = Accounts.get_post!(id)
    changeset = Post.changeset(post, %{})
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn,%{"id" => id, "post" => post_params}, _current_user) do
    post = Accounts.get_post!(id)
    Accounts.update_post(post, post_params)
      |> update_response(conn, post)
  end

  defp update_response({:ok, _}, conn, _post) do
    conn
      |> redirect(to: page_path(conn, :index))
  end

  defp update_response({:error, _error}, conn, post) do
    user_id = conn.assigns.current_user.id
    conn
      |> put_flash(:error, "You cannot post empty status.")
      |> redirect(to: user_post_path(conn, :edit , user_id, post.id ))

  end

  defp post_response({:error, _error}, conn) do
    # require IEx
    # IEx.pry()
    conn
    |> put_flash(:post_error, "this can't be blank!")
    |> redirect(to: page_path(conn, :index))
  end

  defp post_response({:ok, _user}, conn) do
    conn
    |> redirect(to: page_path(conn, :index))
  end



# render(conn, "edit.html", post: post, changeset: changeset)


end
