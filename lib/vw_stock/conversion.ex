defmodule VwStock.Conversion do
  def meters_to_miles(meters), do: round(meters * 0.000621371)
  def coord_string_to_tuple(string) do
    [lat, long] =
      string
      |> String.split(",")
      |> Stream.map(&String.to_charlist/1)
      |> Enum.map(&List.to_float/1)
    {long, lat}
  end
end
