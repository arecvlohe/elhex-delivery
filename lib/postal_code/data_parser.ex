defmodule ElhexDelivery.PostalCode.DataParser do
  @postal_codes_filepath "data/2016_Gaz_zcta_national.txt"

  

  def parse_data do
    [_header | data_rows] = File.read!(@postal_codes_filepath) |> String.split("\n")

    data_rows
    |> Stream.map(&(String.split(&1, "\t")))
    |> Stream.filter(&data_row?/1)
    |> Stream.map(&parse_data_columns/1)
    |> Stream.map(&format_row/1)
    |> Enum.into(%{})
  end

  defp data_row?(row) do
    case row do
        [_postal_code, _, _, _, _, _latitude, _longitude] -> true
        _ -> false
      end
  end

  defp parse_data_columns(row) do
    [postal_code, _, _, _, _, latitude, longitude] = row
    [postal_code, latitude, longitude]
  end

  defp format_row(row) do
    [postal_code, latitude, longitude] = row
    latitude = string_to_float(latitude)
    longitude = string_to_float(longitude)

    {postal_code, {latitude, longitude}}
  end

  defp string_to_float(str) do
    str
     |> String.trim
     |> String.to_float
  end

end
