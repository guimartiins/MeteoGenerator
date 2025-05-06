defmodule MeteoGenerator.Application do
  @moduledoc """
  This module is responsible for starting the application and fetching weather data for multiple cities.
  """

  @cities [
    {"São Paulo", -23.55, -46.63},
    {"Belo Horizonte", -19.92, -43.94},
    {"Curitiba", -25.43, -49.27}
  ]

  def start(_type, _args) do
    Application.ensure_all_started(:httpoison)

    tasks =
      Enum.map(@cities, fn {city, lat, lng} ->
        Task.async(fn ->
          case MeteoClient.get_weather(lat, lng, timezone: "America/Sao_Paulo") do
            {:ok, response} ->
              {city, MeteoService.get_average(response)}

            {:error, reason} ->
              {city, "Error: #{reason}"}
          end
        end)
      end)

    Task.await_many(tasks)
    |> Enum.each(fn {city, result} ->
      IO.puts("#{city}: #{result}")
    end)

    {:ok, self()}
  end
end
