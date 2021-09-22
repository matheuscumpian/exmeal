defmodule Exmeal.Repo.Migrations.AddNotNullToMealsColumns do
  use Ecto.Migration

  def change do
    alter table("meals") do
      modify :descricao, :string, null: false
      modify :data, :naive_datetime, null: false
      modify :calorias, :integer, null: false
    end
  end
end
