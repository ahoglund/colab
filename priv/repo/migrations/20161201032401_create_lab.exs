defmodule Colab.Repo.Migrations.CreateLab do
  use Ecto.Migration

  def change do
    create table(:labs) do
      add :name, :string
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:labs, [:creator_id])

  end
end
