defmodule ColabWeb.UserController do
  use ColabWeb, :controller
  alias Colab.User

  plug :authenticate_user when action in [:index, :show]
  plug :authorized_user when action in [:show]

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
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
