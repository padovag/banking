defmodule Banking.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def parse_changeset_error(_changeset = %Ecto.Changeset{errors: errors}) do
    errors
    |> Enum.map(fn {field, {error, _}} -> "The field #{field} #{error}" end)
    |> Enum.join(" and ")
  end

  def into_regular_struct(%__MODULE__{name: name, email: email, password: password}) do
    %{
      name: name,
      email: email,
      password: password
    }
  end
end
