defmodule Colab.AuthTest do
  use Colab.ConnCase
  alias Colab.Auth

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Colab.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  test "authenticate_user halts when no current_user", %{conn: conn} do
    conn = Auth.authenticate_user(conn, [])

    assert conn.halted
  end

  test "authenticate_user passes when current_user", %{conn: conn} do
    conn =
      conn
      |> assign(:current_user, %Colab.User{})
      |> Auth.authenticate_user([])

    refute conn.halted
  end

  test "login puts the user in the session", %{conn: conn} do
    login_conn =
      conn
      |> Auth.login(%Colab.User{id: 1})
      |> send_resp(:ok, "")

      next_conn = get(login_conn, "/")
      assert get_session(next_conn, :user_id) == 1
  end

  test "logout removes user from session", %{conn: conn} do
    logout_conn =
      conn
      |> Auth.logout()
      |> send_resp(:ok, "")

      next_conn = get(logout_conn, "/")
      refute get_session(next_conn, :user_id)
  end

  test "call puts user from session into assigns as current_user", %{conn: conn} do
    user = insert_user()
    conn =
      conn
      |> put_session(:user_id, user.id)
      |> Auth.call(Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "call with no session sets current_user to nil", %{conn: conn} do
    conn = Auth.call(conn, Repo)
    assert conn.assigns.current_user == nil
  end

  test "login_by_username_and_pass passes with correct creds", %{conn: conn} do
    user = insert_user
    {:ok, conn } =
      conn
      |> Auth.login_by_username_and_pass(user.username, user.password, repo: Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "login_by_username_and_pass halts if user not found", %{conn: conn} do
    assert {:error, :unauthorized, _conn } =
      Auth.login_by_username_and_pass(conn, "user", "pass", repo: Repo)
  end

  test "login_by_username_and_pass halts if wrong password", %{conn: conn} do
    user = insert_user
    assert {:error, :unauthorized, _conn } =
      Auth.login_by_username_and_pass(conn, user.username, "badpass", repo: Repo)
  end
end
