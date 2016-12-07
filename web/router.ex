defmodule Colab.Router do
  use Colab.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Colab.Auth, repo: Colab.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Colab do
    pipe_through :browser
    get "/", PageController, :index
    resources "/sessions",  SessionController, only: [:new, :create, :delete]
    get "/login", SessionController, :new
    get "/logout", SessionController, :delete
    get "/signup", UserController, :new
    resources "/users", UserController, only: [:new, :create]

    pipe_through [:browser, :authenticate_user]
    resources "/labs", LabController
    resources "/users", UserController, only: [:index, :show, :edit, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Colab do
  #   pipe_through :api
  # end
end
