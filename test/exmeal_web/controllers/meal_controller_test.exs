defmodule ExmealWeb.MealControllerTest do
  use ExmealWeb.ConnCase

  alias Exmeal.Meals
  alias Exmeal.Meal

  @create_attrs %{
    calorias: 42,
    data: ~N[2010-04-17 14:00:00],
    descricao: "some descricao"
  }

  @update_attrs %{
    calorias: 43,
    data: ~N[2011-05-18 15:01:01],
    descricao: "some updated descricao"
  }
  @invalid_attrs %{calorias: nil, data: nil, descricao: nil}

  def fixture(:meal) do
    {:ok, meal} = Meals.create_meal(@create_attrs)
    meal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all meals", %{conn: conn} do
      conn = get(conn, Routes.meals_path(conn, :index))
      assert json_response(conn, 200) == []
    end
  end

  describe "create meal" do
    test "renders meal when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.meals_path(conn, :create), %{
          "data" => "2021-09-22T15:03:10",
          "calorias" => 20,
          "descricao" => "almoco"
        })

      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.meals_path(conn, :show, id))

      assert %{
               "data" => "2021-09-22T15:03:10",
               "calorias" => 20,
               "descricao" => "almoco"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.meals_path(conn, :create), meal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update meal" do
    setup [:create_meal]

    test "renders meal when data is valid", %{conn: conn, meal: %Meal{id: id} = meal} do
      conn =
        put(conn, Routes.meals_path(conn, :update, meal),
         %{
            calorias: 42,
            data: ~N[2010-04-17 14:00:00],
            descricao: "some descricao"
          }
        )

      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, Routes.meals_path(conn, :show, id))

      assert  %{
        "calorias" => 42,
        "data" => "2010-04-17T14:00:00",
        "descricao" => "some descricao",
      } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, meal: meal} do
      conn = put(conn, Routes.meals_path(conn, :update, meal), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete meal" do
    setup [:create_meal]

    test "deletes chosen meal", %{conn: conn, meal: meal} do
      conn = delete(conn, Routes.meals_path(conn, :delete, meal))
      assert response(conn, 204)

      conn = get(conn, Routes.meals_path(conn, :show, meal))
      assert response(conn, 404)
    end
  end

  defp create_meal(_) do
    meal = fixture(:meal)
    %{meal: meal}
  end
end
