defmodule ColabWeb.Router do
  use ColabWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Colab.Auth, repo: Colab.Repo
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ColabWeb do
    pipe_through :browser
    get "/", PageController, :index
    resources "/sessions",  SessionController, only: [:new, :create, :delete]
    resources "/users", UserController, only: [:new, :create]
    get "/login", SessionController, :new
    get "/logout", SessionController, :delete
    get "/signup", UserController, :new
  end

  scope "/", ColabWeb do
    pipe_through [:browser, :authenticate_user]
    resources "/labs", LabController
    resources "/users", UserController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Colab do
  #   pipe_through :api
  # end
end
