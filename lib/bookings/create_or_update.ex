defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        id: id,
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }) do
    case Booking.build(complete_date, local_origin, local_destination, user_id) do
      {:ok, booking} -> save_booking({:ok, %{booking | id: id}})
      error -> error
    end
  end

  def call(%{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }) do
    complete_date
    |> Booking.build(local_origin, local_destination, user_id)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)
  end

  defp save_booking({:error, _reason} = error), do: error
end
