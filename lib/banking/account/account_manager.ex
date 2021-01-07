defmodule Banking.AccountManager do
  alias Banking.TransactionReport

  def withdraw(amount, account_from) do
    TransactionReport.register_withdraw(amount, account_from)
  end

  def transfer(amount, account_from, account_to) do
    TransactionReport.register_transfer(amount, account_from, account_to)
  end

  def deposit(amount, account_to) do
    TransactionReport.register_deposit(amount, account_to)
  end

end
