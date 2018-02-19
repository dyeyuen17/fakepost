defmodule Fakepost.Accounts.Guardian do
  use Guardian, otp_app: :fakepost

  alias Fakepost.Accounts

  def subject_for_token(user, _claims) do
    {:ok, user.id |> to_string}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    |> Accounts.get_user!
    {:ok, user}
  end

  # def subject_for_token(_, _) do
  #   {:error, :reason_for_error}
  # end
  #
  # def resource_from_claims(_claims) do
  #   {:error, :reason_for_error}
  # end

end
