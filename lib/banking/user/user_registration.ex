defmodule Banking.UserRegistration do
  alias Banking.Repo
  alias Banking.Model.User
  alias Banking.Model.Account

  def register(user = %{"name" => _name, "email" => _email, "password" => _password}) do
    User.changeset(%User{}, user)
    |> create_user_with_new_account(user)
  end

  defp create_user_with_new_account(changeset = %Ecto.Changeset{valid?: false}, _user), do: {:error, changeset |> User.parse_changeset_error()}
  defp create_user_with_new_account(%Ecto.Changeset{valid?: true}, _user = %{"name" => name, "email" => email, "password" => password}) do
    account = %Account{balance: "1000"}

    %User{
      name: name,
      email: email,
      password: password,
      account: account
    }
    |> Repo.insert()
    |> result()
  end

  defp result({:ok, user}) do
    {:ok, user
      |> User.into_regular_struct()
      |> Map.put(:account, user.account |> Account.into_regular_struct())
    }
  end
end
