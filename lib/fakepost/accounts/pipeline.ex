defmodule Fakepost.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
  otp_app: :fakepost,
  error_handler: Fakepost.Accounts.ErrorHandler,
  module: Fakepost.Accounts.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true

end
