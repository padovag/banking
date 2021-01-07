defmodule Banking.TokenManager do
  use Guardian, otp_app: :banking

  alias Banking.Model.User

  def generate_token(user = %User{}), do: generate_token(user, Mix.env())
  def generate_token(_user = %User{}, _env = :test), do: "testToken"
  def generate_token(user = %User{}, _env) do
    {:ok, token, _options} = encode_and_sign(user)
    token
  end

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(_claims) do
    {:ok, :noop}
  end
end
