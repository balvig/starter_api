require "open-weather-api"

module StarterApi
  class Forecast
    API_KEY = ENV["OPEN_WEATHER_API_KEY"] || raise("Please set OPEN_WEATHER_API_KEY")

    def rain_probability
      (rain_data * 100).round
    end

    def summary
      data["weather"].first["description"]
    end

    def temperature
      data["main"]["temp"].round
    end

    private

      def rain_data
        data.fetch("rain", {})["3h"] || 0
      end

      def data
        @_data ||= fetch["list"].first
      end

      def fetch
        api.raw "forecast", q: "Tokyo,jp", units: "metric"
      end

      def api
        @_api ||= OpenWeatherAPI::API.new api_key: API_KEY
      end
  end
end
