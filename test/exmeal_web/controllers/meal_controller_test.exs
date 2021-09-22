defmodule ExmealWeb.MealControllerTest do
  use ExmealWeb.ConnCase

  alias Exmeal.Meals
  alias Exmeal.Meals.Meal

  @create_attrs %{
    calorias: 42,
    data: ~N[2010-04-17 14:00:00],
    descricao: "some descricao",
    id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    calorias: 43,
    data: ~N[2011-05-18 15:01:01],
    descricao: "some updated descricao",
    id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{calorias: nil, data: nil, descricao: nil, id: nil}

  def fixture(:meal) do
    {:ok, meal} = Meals.create_meal(@create_attrs)
    meal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all meals", %{conn: conn} do
      conn = get(conn, Routes.meal_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create meal" do
    test "renders meal when data is valid", %{conn: conn} do
      conn = post(conn, Routes.meal_path(conn, :create), meal: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.meal_path(conn, :show, id))

      assert %{
               "id" => id,
               "calorias" => 42,
               "data" => "2010-04-17T14:00:00",
               "descricao" => "some descricao",
               "id" => "7488a646-e31f-11e4-aace-600308960662"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.meal_path(conn, :create), meal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update meal" do
    setup [:create_meal]

    test "renders meal when data is valid", %{conn: conn, meal: %Meal{id: id} = meal} do
      conn = put(conn, Routes.meal_path(conn, :update, meal), meal: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.meal_path(conn, :show, id))

      assert %{
               "id" => id,
               "calorias" => 43,
               "data" => "2011-05-18T15:01:01",
               "descricao" => "some updated descricao",
               "id" => "7488a646-e31f-11e4-aace-600308960668"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, meal: meal} do
      conn = put(conn, Routes.meal_path(conn, :update, meal), meal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete meal" do
    setup [:create_meal]

    test "deletes chosen meal", %{conn: conn, meal: meal} do
      conn = delete(conn, Routes.meal_path(conn, :delete, meal))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.meal_path(conn, :show, meal))
      end
    end
  end

  defp create_meal(_) do
    meal = fixture(:meal)
    %{meal: meal}
  end
end
