defmodule ColabWeb.LabController do
  use ColabWeb, :controller
  alias Colab.Lab

  plug :authenticate_user

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end

  def show(conn, %{"id" => id}, user) do
    lab = Repo.get!(Lab, id)
    render(conn, "show.html", lab: lab)
  end

  def new(conn, _, user) do
    lab = Lab.changeset(%Lab{})
    render conn, "new.html", lab: lab
  end

  def create(conn, %{"lab" => lab_params}, user) do
    changeset = Lab.changeset(%Lab{}, lab_params)

    case Repo.insert(changeset) do
      {:ok, lab} ->
        conn
        |> put_flash(:info, "Lab created successfully.")
        |> redirect(to: lab_path(conn, :show, lab))
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def index(conn, _, user) do
    labs = Repo.all(user_labs(user))
    render(conn, "index.html", labs: labs)
  end


  defp user_labs(user) do
    assoc(user, :labs)
  end
end
