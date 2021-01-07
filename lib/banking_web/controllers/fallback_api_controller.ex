defmodule Banking.FallbackApiController do
  use BankingWeb, :controller

  def call(conn, {:error, error_message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(Banking.ApiView)
    |> render(:error, %{message: error_message})
  end

  def call(conn, {:unauthorized, _user}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(Banking.ApiView)
    |> render(:error, %{message: "The password is incorrect"})
  end

  def call(conn, {:not_found, nil}) do
    conn
    |> put_status(:bad_request)
    |> put_view(Banking.ApiView)
    |> render(:error, %{message: "The email is not registered"})
  end

end
