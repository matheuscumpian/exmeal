defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  alias Exmeal.User

  # Generate an UUID for the primary key automatically
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:descricao, :data, :calorias, :user_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "meals" do
    field :calorias, :integer
    field :data, :naive_datetime
    field :descricao, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
