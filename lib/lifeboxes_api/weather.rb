require "open-weather-api"
require "lifeboxes_api/weather_report"

module LifeboxesApi
  class Weather
    API_KEY = ENV["OPEN_WEATHER_API_KEY"] || raise("Please set OPEN_WEATHER_API_KEY")

    def forecast
      forecast_data.first(3).map do |data|
        WeatherReport.new(data)
      end
    end

    private

      def forecast_data
        @_data ||= fetch["list"]
      end

      def fetch
        api.forecast :hourly, city: "Setagaya", country_code: "jp"
      end

      def api
        @_api ||= OpenWeatherAPI::API.new api_key: API_KEY
      end
  end
end
