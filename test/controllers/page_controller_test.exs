defmodule Colab.PageControllerTest do
  use ColabWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert String.contains?(conn.resp_body, "Login")
    assert String.contains?(conn.resp_body, "Register")
    refute String.contains?(conn.resp_body, "Log Out")
  end

  test "GET / as logged in user", %{conn: conn} do
    user = insert_user(username: "test user")
    conn = assign(conn, :current_user, user)
    conn = get conn, "/"

    assert String.contains?(conn.resp_body, "Log Out")
    assert String.contains?(conn.resp_body, "Profile")
    refute String.contains?(conn.resp_body, "Login")
  end
end
