require "open-weather-api"
require "lifeboxes_api/weather_report"

module LifeboxesApi
  class Weather
    API_KEY = ENV["OPEN_WEATHER_API_KEY"] || raise("Please set OPEN_WEATHER_API_KEY")
    DEFAULTS = {
      city: "Setagaya",
      country_code: "jp"
    }

    def forecast
      hourly_forecast_data.first(3).map do |data|
        WeatherReport.new(data)
      end
    end

    def current_temperature
      current_data["main"]["temp"].round
    end

    def todays_lowest_temperature
      todays_forecast_data["main"]["temp_min"].round
    end

    private

      def hourly_forecast_data
        @_forecast_data ||= api.forecast(:hourly, DEFAULTS)["list"]
      end

      def current_data
        @_current_data ||= api.current(DEFAULTS)
      end

      def todays_forecast_data
        @_todays_forecast_data ||= api.forecast(:daily, DEFAULTS)["list"].first
      end

      def api
        @_api ||= OpenWeatherAPI::API.new api_key: API_KEY
      end
  end
end
