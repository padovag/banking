defmodule Banking.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false, size: 191
      add :email, :string, null: false, size: 191
      add :password, :string, null: false, size: 191
      timestamps()
    end

    create index("users", [:name], unique: true)
    create index("users", [:email], unique: true)
  end
end
