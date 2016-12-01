defmodule Colab.Lab do
  use Colab.Web, :model

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
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
