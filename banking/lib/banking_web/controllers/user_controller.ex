defmodule Banking.UserController do
  use BankingWeb, :controller

  alias Banking.UserRegistration

  action_fallback Banking.FallbackApiController

  def register(conn, params = %{"name" => name, "email" => email, "password" => password}) do
    with {:ok, user} <- UserRegistration.register(params) do
      conn
      |> put_view(Banking.ApiView)
      |> put_status(:created)
      |> render(:success, %{data: user})
    end
  end
end
