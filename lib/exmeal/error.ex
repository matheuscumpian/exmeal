defmodule Exmeal.Error do
  @keys [:status, :payload]

  @enforce_keys @keys

  defstruct @keys

  def get_not_found_error(resource, id) do
    %__MODULE__{
      status: :not_found,
      payload: %{
        message: "Cannot find #{resource} with id #{id}"
      }
    }
  end
end
