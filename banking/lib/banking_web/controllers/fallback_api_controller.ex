defmodule Banking.FallbackApiController do
  use BankingWeb, :controller

  def call(conn, {:error, error_message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(Banking.ApiView)
    |> render(:error, %{message: error_message})
  end

end
