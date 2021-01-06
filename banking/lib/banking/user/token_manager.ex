defmodule Banking.TokenManager do
  use Guardian, otp_app: :banking

  alias Banking.Model.User

  def generate_token(user = %User{}) do
    {:ok, token, _options} = encode_and_sign(user)
    token
  end

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end
end
