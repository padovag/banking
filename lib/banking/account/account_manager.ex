defmodule Banking.AccountManager do
  alias Banking.Model.Account
  alias Banking.Repo

  @initial_balance 1000

  def create_account(balance \\ @initial_balance) do
    Account.changeset(%Account{}, %{balance: balance})
    |> Repo.insert()
  end

end
