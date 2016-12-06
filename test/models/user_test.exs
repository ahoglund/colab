defmodule Colab.UserTest do
  use Colab.ModelCase, async: true
  alias Colab.User

  @valid_attrs %{name: "test user", password_hash: "secret", username: "testuser"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset does not accept long usernames" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 31))

    assert {:username, "should be at most 30 character(s)"} in errors_on(%User{}, attrs)
  end
end
