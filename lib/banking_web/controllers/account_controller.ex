defmodule Banking.AccountController do
  use BankingWeb, :controller

  alias Banking.AccountManager

  action_fallback Banking.FallbackApiController

  def withdraw(conn, _params = %{"account_from" => account_from, "amount" => amount, "token" => _token}) do
    with {:ok, transaction} <- AccountManager.withdraw(amount, account_from) do
      conn
      |> put_view(Banking.ApiView)
      |> put_status(:created)
      |> render(:success, %{data: transaction})
    end
  end

  def deposit(conn, _params = %{"account_to" => account_to, "amount" => amount, "token" => _token}) do
    with {:ok, transaction} <- AccountManager.deposit(amount, account_to) do
      conn
      |> put_view(Banking.ApiView)
      |> put_status(:created)
      |> render(:success, %{data: transaction})
    end
  end

  def transfer(conn, _params = %{"account_from" => account_from, "account_to" => account_to, "amount" => amount, "token" => _token}) do
    with {:ok, transaction} <- AccountManager.transfer(amount, account_to, account_from) do
      conn
      |> put_view(Banking.ApiView)
      |> put_status(:created)
      |> render(:success, %{data: transaction})
    end
  end
end
