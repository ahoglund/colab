defmodule Colab.UserViewTest do
  use Colab.ConnCase, async: true
  import Phoenix.View
  alias Colab.User

  test "new.html displays new user form", %{conn: conn} do
    content = render_to_string(Colab.UserView, "new.html", conn: conn, changeset: User.changeset(%User{}))

    assert String.contains?(content, "Create User")
  end

  test "show.html displays user profile", %{conn: conn} do
    user = %Colab.User{id: 1, name: "Test User"}
    content = render_to_string(Colab.UserView, "show.html", conn: conn, user: user)

    assert String.contains?(content, user.name)
  end
end

