defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller

  alias Exmeal.Meals
  alias Exmeal.Meal
  alias ExmealWeb.Router.Helpers, as: Routes
  alias ExmealWeb.Endpoint

  action_fallback ExmealWeb.FallbackController

  def index(conn, _params) do
    meals = Meals.list_meals()
    render(conn, "index.json", meals: meals)
  end

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Meals.create_meal(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.meals_path(Endpoint, :show, meal.id))
      |> render("show.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- Meals.get_meal(id) do
      render(conn, "show.json", meal: meal)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %Meal{} = meal} <- Meals.get_meal(id),
         {:ok, %Meal{} = meal} <- Meals.update_meal(meal, params) do
      render(conn, "show.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- Meals.get_meal(id),
         {:ok, %Meal{}} <- Meals.delete_meal(meal) do
      send_resp(conn, :no_content, "")
    end
  end
end
