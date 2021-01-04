defmodule Banking.UserController do
  use BankingWeb, :controller

  alias Banking.UserRegistration
  alias Banking.UserAuthentication

  action_fallback Banking.FallbackApiController

  def register(conn, params = %{"name" => _name, "email" => _email, "password" => _password}) do
    with {:ok, user} <- UserRegistration.register(params) do
      conn
      |> put_view(Banking.ApiView)
      |> put_status(:created)
      |> render(:success, %{data: user})
    end
  end

  def authenticate(conn, params = %{"email" => _email, "password" => _password}) do
    with {:authenticated, user} <- UserAuthentication.authenticate(params) do
      conn
      |> put_view(Banking.ApiView)
      |> put_status(:accepted)
      |> render(:success, %{data: user})
    end
  end
end
