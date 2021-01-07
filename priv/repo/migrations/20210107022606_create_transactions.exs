defmodule Banking.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :decimal, precision: 15, scale: 2
      add :account_from, :string
      add :account_to, :string
      add :action, :string
      add :date, :date

      timestamps()
    end
  end
end
