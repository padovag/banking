defmodule UserControllerTest do
  use BankingWeb.ConnCase

  test "register user successfully", %{conn: conn} do
    params = %{
      "name" => "Mr. Potato Head",
      "email" => "potato_head@gmail.com",
      "password" => "aVeryStrongPassword*123"
    }

    conn = get(conn, "/api/register", params)

    response_body = json_response(conn, :created)
    assert params == response_body["data"]
  end

  test "register user with error", %{conn: conn} do
    params = %{
      "name" => "Mr. Potato Head",
      "email" => "invalid_email",
      "password" => "aVeryStrongPassword*123"
    }

    conn = get(conn, "/api/register", params)

    response_body = json_response(conn, :bad_request)
    assert "The field email has invalid format" == response_body["details"]
  end
end
