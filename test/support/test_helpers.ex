defmodule Colab.TestHelpers do
  alias Colab.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "User",
      username: "user-#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret"
    }, attrs)

    %Colab.User{}
    |> Colab.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_lab(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:labs, attrs)
    |> Repo.insert!()
  end
end
