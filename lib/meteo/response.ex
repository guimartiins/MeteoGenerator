defmodule MeteoResponse do
  @moduledoc """
    Module that represents the Meteo API response.
  """
  @derive {Jason.Encoder, only: [:daily]}
  defstruct [
    :daily
  ]

  @doc """
  Maps the Mateo API response to a struct.
  """
  @spec from_map(map()) :: %MeteoResponse{daily: %{temperature_2m_max: any()}}
  def from_map(map) when is_map(map) do
    daily = %{
      temperature_2m_max: Map.get(map, "daily", %{}) |> Map.get("temperature_2m_max", [])
    }

    %__MODULE__{
      daily: daily
    }
  end
end
