defmodule FakepostWeb.PostController do
  use FakepostWeb, :controller
  alias Fakepost.Accounts.Post
  alias Fakepost.Accounts.User
  alias Fakepost.Repo

  plug :scrub_params, "post" when action in [:create, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, current_user) do
    user = User |> Repo.get!(user_id)

    posts =
      user
      |> user_posts
      |> Repo.all
      |> Repo.preload(:user)

    render(conn, "index.html", posts: posts, user: user)
  end

  def show(conn, %{"user_id" => user_id, "id" => id}, current_user) do
    user = User |>
    post = User |>
  end

  defp user_posts(user) do
    assoc(user, :posts)
  end

  defp user_post_by_id(user, post_id) do
    user
    |> user_posts
    |> Post.get_post(post_id)
  end
end
