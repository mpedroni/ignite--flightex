defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename) do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  defp build_booking_list do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_string/1)
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         local_destination: local_destination,
         local_origin: local_origin,
         user_id: user_id
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
