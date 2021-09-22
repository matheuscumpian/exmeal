defmodule Exmeal.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :descricao, :string
      add :data, :naive_datetime
      add :calorias, :integer

      timestamps()
    end

  end
end
