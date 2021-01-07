defmodule Banking.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :balance, :decimal, precision: 15, scale: 2
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
