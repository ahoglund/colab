defmodule Colab.PageController do
  use Colab.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
