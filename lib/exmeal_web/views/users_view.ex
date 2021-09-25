defmodule ExmealWeb.UsersView do
  use ExmealWeb, :view
  alias ExmealWeb.UsersView

  def render("index.json", %{users: users}) do
    render_many(users, UsersView, "user.json", as: :user)
  end

  def render("show.json", %{user: user}) do
    render_one(user, UsersView, "user.json", as: :user)
  end

  def render("user.json", %{user: user}) do
    user
  end

end
