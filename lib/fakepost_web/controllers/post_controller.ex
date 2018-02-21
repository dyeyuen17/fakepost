defmodule FakepostWeb.PostController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts.Post
  alias Fakepost.Accounts.User
  alias Fakepost.Repo
  alias Fakepost.Accounts
  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false

  plug :scrub_params, "post" when action in [:create]

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

  defp post_response({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: page_path(conn, :index))
  end

  defp post_response({:ok, _user}, conn) do
    conn
    |> redirect(to: page_path(conn, :index))
  end


end
