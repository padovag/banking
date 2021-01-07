defmodule Banking.UserAuthentication do
  alias Banking.Repo
  alias Banking.Model.User
  alias Banking.TokenManager

  def authenticate(_user = %{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: email)

    user
    |> validate_password(password)
    |> generate_token_if_valid()
  end

  defp validate_password(_user = nil, _input_password), do: {:not_found, nil}
  defp validate_password(user = %User{password: actual_password}, input_password)
       when actual_password == input_password, do: {:authenticated, user}
  defp validate_password(user = %User{password: _actual_password}, _input_password), do: {:unauthorized, user |> User.into_regular_struct()}

  defp generate_token_if_valid({:authenticated, user}), do: {:authenticated, user |> User.into_regular_struct(), TokenManager.generate_token(user)}
  defp generate_token_if_valid(invalid_reason), do: invalid_reason
end
