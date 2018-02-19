defmodule Fakepost.Accounts.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    response = type |> to_string
    conn
    |> put_resp_content_type("html")
    |> send_resp(401, response)
  end
end
