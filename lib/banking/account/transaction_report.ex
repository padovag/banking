defmodule Banking.TransactionReport do
  alias Banking.Model.Transaction

  def register_withdraw(amount, account_from) do
    Transaction.changeset(%Transaction{}, %{
      "amount" => amount,
      "account_from" => account_from,
      "action" => "withdraw",
      "date" => DateTime.utc_now()
    })
    |> Repo.insert()
    |> result()
  end

  def register_transfer(amount, account_from, account_to) do
    Transaction.changeset(%Transaction{}, %{
      "amount" => amount,
      "account_from" => account_from,
      "account_to" => account_to,
      "action" => "transfer",
      "date" => DateTime.utc_now()
    })
    |> Repo.insert()
    |> result()
  end

  def register_deposit(amount, account_to) do
    Transaction.changeset(%Transaction{}, %{
      "amount" => amount,
      "account_to" => account_to,
      "action" => "deposit",
      "date" => DateTime.utc_now()
    })
    |> Repo.insert()
    |> result()
  end

  defp result({:ok, transaction}), do: {:ok, transaction |> Transaction.into_regular_struct()}
end
