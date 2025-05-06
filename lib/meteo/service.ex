defmodule MeteoService do
  @moduledoc """
  Module that provides functionality to process weather data from the Open Meteo API.
  """

  @doc """
  Calculates the average temperature from the weather data response.


  ## Parameters
    - `meteo_response`: The response from the Open Meteo API containing weather data.
  ## Returns
    - A string representing the average temperature in Celsius.
  """
  @spec get_average(meteo_response :: %MeteoResponse{}) ::
          String.t()
  def get_average(meteo_response) do
    meteo_response
    |> Map.get(:daily)
    |> Map.get(:temperature_2m_max)
    |> Enum.slice(0..5)
    |> calculate_average()
    |> format()
  end

  defp calculate_average(temperatures) do
    Enum.sum(temperatures) / length(temperatures)
  end

  defp format(average) do
    average
    |> Float.round(1)
    |> to_string()
    |> Kernel.<>("°C")
  end
end
