defmodule Statistics.Repo.Migrations.CreateProperty do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :description, :string
      add :squareMetres, :float
      add :rent, :float

      timestamps()
    end

  end
end
