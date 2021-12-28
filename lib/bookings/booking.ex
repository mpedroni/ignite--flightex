defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id)
      when is_struct(complete_date) and is_bitstring(local_origin) and
             is_bitstring(local_destination) and is_bitstring(user_id) do
    uuid = UUID.uuid4()

    {
      :ok,
      %__MODULE__{
        id: uuid,
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }
    }
  end

  def build(_complete_date, _local_origin, _local_destination, _user_id) do
    {:error, "Invalid parameters"}
  end
end
