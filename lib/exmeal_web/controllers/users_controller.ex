defmodule ExmealWeb.UsersController do
  use ExmealWeb, :controller

  alias Exmeal.User
  alias Exmeal.Users.Create

  action_fallback ExmealWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
