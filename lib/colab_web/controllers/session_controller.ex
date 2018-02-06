defmodule ColabWeb.SessionController do
  use ColabWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Colab.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid Username and/or Password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Colab.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
