defmodule Banking.Model.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :decimal, precision: 15, scale: 2
    field :account_from, :string
    field :account_to, :string
    field :action, :string
    field :date, :date

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :account_from, :account_to, :action, :date])
    |> validate_required([:amount, :action])
  end

  def into_regular_struct(%__MODULE__{
    amount: amount,
    account_from: account_from,
    account_to: account_to,
    action: action,
    date: date
  }) do
    %{
      amount: amount,
      account_from: account_from,
      account_to: account_to,
      action: action,
      date: date
    }
  end

end
