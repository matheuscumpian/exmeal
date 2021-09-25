defmodule Exmeal.Users.Create do
  alias Exmeal.{User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

end
