require "open-weather-api"

module StarterApi
  class Forecast
    API_KEY = ENV["OPEN_WEATHER_API_KEY"]

    def rain_probability
      rain_data || 0
    end

    def description
      "#{summary}, #{temperature}C"
    end

    private

      def summary
        data["weather"].first["description"].capitalize
      end

      def temperature
        data["main"]["temp"].round
      end

      def rain_data
        data.fetch("rain", {})["3h"]
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
