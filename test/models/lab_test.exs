defmodule Colab.LabTest do
  use Colab.ModelCase

  alias Colab.Lab

  @valid_attrs %{name: "some content", creator_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Lab.changeset(%Lab{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Lab.changeset(%Lab{}, @invalid_attrs)
    refute changeset.valid?
  end
end
