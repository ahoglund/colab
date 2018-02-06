defmodule ColabWeb.LabController do
  use ColabWeb, :controller

  plug :authenticate_user

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _, user) do
    labs = Repo.all(user_labs(user))
    render(conn, "index.html", labs: labs)
  end

  def show(conn, %{ "id" => id }) do
    Repo.find(Lab, id)
  end

  defp user_labs(user) do
    assoc(user, :labs)
  end
end
