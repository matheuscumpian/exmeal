defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  # Generate an UUID for the primary key automatically
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:descricao, :data, :calorias]

  @derive {Jason.Encoder, only: [:id, :descricao, :data, :calorias]}

  schema "meals" do
    field :calorias, :integer
    field :data, :naive_datetime
    field :descricao, :string

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
