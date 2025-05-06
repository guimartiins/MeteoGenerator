defmodule MeteoClient do
  @moduledoc """
    Module that interacts with the Open Meteo API to fetch weather data.
  """
  @base_url "https://api.open-meteo.com/v1/forecast"

  @doc """
    Fetches the weather data for a given latitude and longitude.

    ## Parameters
      - `lat`: Latitude of the location.
      - `lng`: Longitude of the location.
      - `options`: Optional parameters for the request.

    ## Returns
      - `{:ok, %MeteoResponse{}}` on success.
      - `{:error, reason}` on failure.
  """
  @spec get_weather(number(), number()) ::
          {:error, any()}
          | {:ok, %MeteoResponse{daily: %{temperature_2m_max: list(number())}}}
  def get_weather(lat, lng, options \\ []) do
    params = [
      latitude: lat,
      longitude: lng,
      daily: "temperature_2m_max",
      timezone: Keyword.get(options, :timezone, "auto")
    ]

    url = @base_url <> "?" <> URI.encode_query(params)

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        decoded_body = Jason.decode!(body)
        {:ok, MeteoResponse.from_map(decoded_body)}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Received status code: #{status_code}, body: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
