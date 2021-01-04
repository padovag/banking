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

  test "authenticate user successfully", %{conn: conn} do
    params = %{
      "name" => "Ms. Already Registered",
      "email" => "already_registed@email.com",
      "password" => "correctPassword*123"
    }
    params |> register_user_to_test()

    conn = get(conn, "/api/auth", params)

    response_body = json_response(conn, :accepted)
    assert params == response_body["data"]
  end

  test "authenticate user with incorrect password, should return unauthorized", %{conn: conn} do
    params = %{
      "name" => "Ms. Already Registered",
      "email" => "already_registed@email.com",
      "password" => "correctPassword*123"
    }
    params |> register_user_to_test()

    conn = get(conn, "/api/auth", Map.update(params, "password", nil, fn _actual_password -> "wrongPassword" end))

    response_body = json_response(conn, :unauthorized)
    assert "The password is incorrect" == response_body["details"]
  end

  test "authenticate with not registered user", %{conn: conn} do
    params = %{
      "email" => "not_registered@email.com",
      "password" => "anyPassword"
    }

    conn = get(conn, "/api/auth", params)

    response_body = json_response(conn, :bad_request)
    assert "The email is not registered" == response_body["details"]
  end

  defp register_user_to_test(user) do
    Banking.UserRegistration.register(user)
  end
end
