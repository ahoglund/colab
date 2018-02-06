defmodule ColabWeb.PageController do
  use ColabWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
