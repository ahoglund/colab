defmodule Colab.LabControllerTest do
  use Colab.ConnCase

  setup %{ conn: conn } = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "returns 302 and halts", %{ conn: conn } do
    Enum.each([
      get(conn, lab_path(conn, :new)),
      get(conn, lab_path(conn, :index)),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag login_as: "lab-user"
  test "lists a user's labs", %{ conn: conn, user: user } do
    user_lab   = insert_lab(user, name: "test lab")
    user_lab_2 = insert_lab(insert_user(username: "another-user"), name: "test lab 2")

    conn = get conn, lab_path(conn, :index)

    assert html_response(conn, 200) =~ ~r/Labs/
    assert String.contains?(conn.resp_body, user_lab.name)
    refute String.contains?(conn.resp_body, user_lab_2.name)
  end
end
