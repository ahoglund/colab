defmodule Colab.LabController do
  use Colab.Web, :controller

  plug :authenticate_user

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _, user) do
    labs = Repo.all(user_labs(user))
    render(conn, "index.html", labs: labs)
  end

  def new(conn, _, user) do
    render conn, "new.html"
  end

  def show(conn, %{ "id" => id }) do
    lab = Repo.find(Lab, id)
  end

  defp user_labs(user) do
    assoc(user, :labs)
  end
end
