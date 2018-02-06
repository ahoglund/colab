defmodule ColabWeb.UserController do
  use ColabWeb, :controller
  alias Colab.User

  plug :authenticate_user when action in [:index, :show]

  def authorized_user(conn, user) do
    if conn.assigns.current_user == user do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized to view that page")
      |> redirect(to: user_path(conn, :show, conn.assigns.current_user))
      |> halt()
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    authorized_user(conn, user)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "user" => user_params }) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Colab.Auth.login(user)
        |> put_flash(:info, "#{user.name} created.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops! Check the errors below:")
        |> render("new.html", changeset: changeset)
    end
  end
end
