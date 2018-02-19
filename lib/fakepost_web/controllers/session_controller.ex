defmodule FakepostWeb.SessionController do
  use FakepostWeb, :controller
  # alias Fakepost.Accounts.User
  alias Fakepost.Accounts
  alias Fakepost.Accounts.Guardian

  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _) do
    render conn, "new.html"
  end

  def authenticate_user(conn, %{"session" => %{"email" => email, "password" => password}}) do
    Accounts.authenticate(email, password)
    |> login_reply(conn)
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:info, error)
    |> redirect(to: "/new")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: page_path(conn, :index))
    # |> redirect(to: "/new")
  end

  def delete(conn, _) do
    conn
    |> logout
  end

  defp logout(conn) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:info, "Session Ended.")
    |> redirect(to: page_path(conn, :index))
  end


end
