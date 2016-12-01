defmodule Colab.PageControllerTest do
  use Colab.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to CoLab"
  end
end
