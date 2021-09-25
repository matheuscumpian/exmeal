defmodule Exmeal.Error do
  @keys [:status, :payload]

  @enforce_keys @keys

  defstruct @keys

  def get_error(status, result) when is_atom(status) or is_integer(status), do: %__MODULE__{status: status, payload: result}
  def get_error(_status, result), do: %__MODULE__{status: :bad_request, payload: result}

  def get_not_found_error(resource, id) do
    %__MODULE__{
      status: :not_found,
      payload: %{
        message: "Cannot find #{resource} with id #{id}"
      }
    }
  end
end
