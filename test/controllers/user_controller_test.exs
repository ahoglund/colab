defmodule Colab.UserControllerTest do
  use Colab.ConnCase

  test "show.html redirects when logged out", %{conn: conn} do
    user = insert_user
    conn = get conn, user_path(conn, :show, user)

    assert html_response(conn, 302)
    assert redirected_to(conn) == page_path(conn, :index)
    assert conn.halted
  end

  test "show.html redirects when logged in as diff user", %{conn: conn} do
    user  = insert_user
    user2 = insert_user
    conn = assign(conn, :current_user, user)
    conn = get conn, user_path(conn, :show, user2)

    assert html_response(conn, 302)
    assert redirected_to(conn) == user_path(conn, :show, user)
  end

  test "new.html", %{conn: conn} do
  end

  test "create.html", %{conn: conn} do
  end
end
