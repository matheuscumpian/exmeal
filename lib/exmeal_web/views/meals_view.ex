defmodule ExmealWeb.MealsView do
  use ExmealWeb, :view
  alias ExmealWeb.MealsView

  def render("index.json", %{meals: meals}) do
    render_many(meals, MealsView, "meal.json", as: :meal)
  end

  def render("show.json", %{meal: meal}) do
    render_one(meal, MealsView, "meal.json", as: :meal)
  end

  def render("meal.json", %{meal: meal}) do
    %{
      id: meal.id,
      descricao: meal.descricao,
      data: meal.data,
      calorias: meal.calorias
    }
  end
end
