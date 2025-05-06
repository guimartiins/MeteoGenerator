defmodule MeteoServiceTest do
  use ExUnit.Case
  doctest MeteoService

  describe "get_average/1" do
    test "correctly calculates average temperature for 6 days" do
      meteo_response = %MeteoResponse{
        daily: %{
          temperature_2m_max: [20.0, 22.0, 24.0, 26.0, 28.0, 30.0, 32.0]
        }
      }

      assert MeteoService.get_average(meteo_response) == "25.0°C"
    end

    test "handles decimal temperatures" do
      meteo_response = %MeteoResponse{
        daily: %{
          temperature_2m_max: [20.5, 21.5, 22.5, 23.5, 24.5, 25.5]
        }
      }

      assert MeteoService.get_average(meteo_response) == "23.0°C"
    end

    test "rounds to one decimal place" do
      meteo_response = %MeteoResponse{
        daily: %{
          temperature_2m_max: [20.0, 20.0, 20.0, 20.0, 20.0, 21.0]
        }
      }

      assert MeteoService.get_average(meteo_response) == "20.2°C"
    end
  end
end
