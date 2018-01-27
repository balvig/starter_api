require "open-weather-api"
require "lifeboxes_api/apis/weather_report"

module LifeboxesApi
  class Weather
    API_KEY = ENV["OPEN_WEATHER_API_KEY"] || raise("Please set OPEN_WEATHER_API_KEY")
    DEFAULTS = {
      city: "Setagaya",
      country_code: "jp"
    }

    def forecast
      reports.first(3)
    end

    def current_temperature
      reports.first.temperature
    end

    def todays_lowest_temperature
      todays_lowest_temperatures.min
    end

    private

      def todays_lowest_temperatures
        reports.map(&:lowest_temperature)
      end

      def reports
        data_sources.map do |data|
          WeatherReport.new(data)
        end
      end

      def data_sources
        [current_data] + forecast_data.first(3)
      end

      def todays_forecast_data
        forecast_data.find_all do |data|
          Time.at(data["dt"]).to_date == Date.today
        end
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
