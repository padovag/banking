defmodule BankingWeb.Router do
  use BankingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BankingWeb do
    pipe_through :browser
  end

   scope "/api", Banking do
     pipe_through :api

     get "/register", UserController, :register
     get "/auth", UserController, :authenticate

     get "/account/withdraw", AccountController, :withdraw
     get "/account/deposit", AccountController, :deposit
     get "/account/transfer", AccountController, :transfer
   end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BankingWeb.Telemetry
    end
  end
end
