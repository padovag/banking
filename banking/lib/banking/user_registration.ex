defmodule Banking.UserRegistration do
  alias Banking.Repo
  alias Banking.Model.User

  def register(user = %{"name" => _name, "email" => _email, "password" => _password}) do
    User.changeset(%User{}, user)
    |> Repo.insert()
    |> result()
  end

  defp result({:ok, user}), do: {:ok, user |> User.into_regular_struct()}
  defp result({:error, changeset}), do: {:error, changeset |> User.parse_changeset_error()}

end
