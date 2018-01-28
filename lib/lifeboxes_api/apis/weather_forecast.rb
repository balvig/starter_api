require "open-weather-api"
require "lifeboxes_api/apis/weather_report"

module LifeboxesApi
  class WeatherForecast
    API_KEY = ENV["OPEN_WEATHER_API_KEY"] || raise("Please set OPEN_WEATHER_API_KEY")
    DEFAULTS = {
      city: "Setagaya",
      country_code: "jp"
    }

    def reports
      forecast_data.first(3).map do |data|
        WeatherReport.new(data)
      end
    end

    private

      def forecast_data
        @_forecast_data ||= api.forecast(:hourly, DEFAULTS)["list"]
      end

      def api
        @_api ||= OpenWeatherAPI::API.new api_key: API_KEY
      end
  end
end
