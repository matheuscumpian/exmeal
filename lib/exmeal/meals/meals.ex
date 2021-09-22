defmodule Exmeal.Meals do
  @moduledoc """
  The Meals context.
  """

  import Ecto.Query, warn: false
  alias Exmeal.Repo

  alias Exmeal.{Error, Meal}

  @doc """
  Returns the list of meals.

  ## Examples

      iex> list_meals()
      [%Meal{}, ...]

  """
  def list_meals do
    Repo.all(Meal)
  end

  @doc """
  Gets a single meal.

  Raises `Ecto.NoResultsError` if the Meal does not exist.

  ## Examples

      iex> get_meal!(123)
      %Meal{}

      iex> get_meal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meal!(id), do: Repo.get!(Meal, id)

  @doc """
  Gets a single meal.

  Raises `Ecto.NoResultsError` if the Meal does not exist.

  ## Examples

      iex> get_meal(123)
      {:ok, %Meal{}}

      iex> get_meal(456)
      {:error, "Cannot find meal"}

  """
  def get_meal(id) do
    case Repo.get(Meal, id) do
      %Meal{} = meal ->
        {:ok, meal}

      nil ->
        Error.get_not_found_error("meal", id)
    end
  end

  @doc """
  Creates a meal.

  ## Examples

      iex> create_meal(%{field: value})
      {:ok, %Meal{}}

      iex> create_meal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meal(attrs \\ %{}) do
    %Meal{}
    |> Meal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meal.

  ## Examples

      iex> update_meal(meal, %{field: new_value})
      {:ok, %Meal{}}

      iex> update_meal(meal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meal(%Meal{} = meal, attrs) do
    meal
    |> Meal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a meal.

  ## Examples

      iex> delete_meal(meal)
      {:ok, %Meal{}}

      iex> delete_meal(meal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meal(%Meal{} = meal) do
    Repo.delete(meal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meal changes.

  ## Examples

      iex> change_meal(meal)
      %Ecto.Changeset{data: %Meal{}}

  """
  def change_meal(%Meal{} = meal, attrs \\ %{}) do
    Meal.changeset(meal, attrs)
  end
end
