defmodule Exmeal.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Exmeal.Meal

  # Generate an UUID for the primary key automatically
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :cpf, :email]

  @derive {Jason.Encoder, only: [:id, :name, :cpf, :email]}

  schema "users" do
    field :name, :string
    field :cpf, :string
    field :email, :string

    has_many :meals, Meal

    timestamps()
  end

  @doc false
  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cpf, is: 11)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
  end
end
