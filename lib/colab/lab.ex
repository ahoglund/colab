defmodule Colab.Lab do
  use ColabWeb, :model

  schema "labs" do
    field :name, :string
    belongs_to :creator, Colab.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :creator_id])
    |> validate_required([:name, :creator_id])
  end
end
