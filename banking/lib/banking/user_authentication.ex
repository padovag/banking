defmodule Banking.UserAuthentication do
  alias Banking.Repo
  alias Banking.Model.User

  def authenticate(user = %{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: email)

    user
    |> validate_password(password)
  end

  defp validate_password(_user = nil, _input_password), do: {:not_found, nil}
  defp validate_password(user = %User{password: actual_password}, input_password)
       when actual_password == input_password, do: {:authenticated, user |> User.into_regular_struct()}
  defp validate_password(user = %User{password: actual_password}, input_password), do: {:unauthorized, user |> User.into_regular_struct()}
end
