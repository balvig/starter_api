require "open-weather-api"
require "lifeboxes_api/apis/weather_report"

module LifeboxesApi
  class Weather
    API_KEY = ENV["OPEN_WEATHER_API_KEY"] || raise("Please set OPEN_WEATHER_API_KEY")
    DEFAULTS = {
      city: "Setagaya",
      country_code: "jp"
    }

    def current
      WeatherReport.new(current_data)
    end

    def forecasts
      forecast_data.first(3).map do |data|
        WeatherReport.new(data)
      end
    end

    def lowest_temperature
      all_lowest_temperatures.min
    end

    private

      def all_lowest_temperatures
        ([current] + forecasts).map(&:lowest_temperature)
      end

      def forecast_data
        @_forecast_data ||= api.forecast(:hourly, DEFAULTS)["list"]
      end

      def current_data
        @_current_data ||= api.current(DEFAULTS)
      end

      def api
        @_api ||= OpenWeatherAPI::API.new api_key: API_KEY
      end
  end
end
