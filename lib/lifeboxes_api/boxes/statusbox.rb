require "lifeboxes_api/apis/weather_forecast"

module LifeboxesApi
  class Statusbox
    def to_json
      {
        message: messages.join("\n"),
      }.to_json
    end

    private

      def messages
        [
          Date.today.strftime("%A"),
          "---",
          "High: #{current_weather.temperature}C",
          "Low: #{lowest_temperature}C"
        ]
      end

      def temperatures
        [current_weather_message, lowest_temperature_message]
      end

      def lowest_temperature
        all_lowest_temperatures.min
      end

      def all_lowest_temperatures
        ([current_weather] + forecasts).map(&:lowest_temperature)
      end

      def current_weather
        weather.current
      end

      def forecasts
        weather.reports
      end

      def weather
        @_weather ||= WeatherForecast.new
      end
  end
end
