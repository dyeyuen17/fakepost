defmodule FakepostWeb.UserController do
  use FakepostWeb, :controller

  alias Fakepost.Accounts
  alias Fakepost.Accounts.User
  alias Fakepost.Accounts.Guardian

  plug :scrub_params, "user" when action in [:create]

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        %{"email" => email, "password" => password} = user_params
        Accounts.authenticate(email,password)
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
     end
  end

end
