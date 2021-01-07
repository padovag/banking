defmodule Banking.Model.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :balance, :string
    belongs_to :user, Banking.Model.User

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:balance])
    |> validate_required([:balance])
  end

  def into_regular_struct(%__MODULE__{balance: balance}), do: %{balance: balance}
end
