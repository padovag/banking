defmodule Banking.ApiView do
  use BankingWeb, :view

  alias Banking.Model.User

  def render("success.json", %{data: data}) do
    %{
      status: :success,
      message: "Action performed successfully",
      data: data
    }
  end

  def render("error.json", %{message: message}) do
    %{
      status: :error,
      message: "Action performed errored",
      details: message
    }
  end

end
