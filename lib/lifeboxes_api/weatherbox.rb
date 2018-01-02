require "lifeboxes_api/weather"

module LifeboxesApi
  class Weatherbox
    def to_json
      {
        led_values: led_values,
        temperatures: temperatures,
      }.to_json
    end

    private

      def led_values
        weather_leds
      end

      def weather_leds
        weather.forecast.map do |report|
          case report.rain_intensity
          # when :light_rain then 1
          when :heavy_rain then 2
          else 0
          end
        end
      end

      def temperatures
        [current_temperature, lowest_temperature]
      end

      def current_temperature
        "Now: #{weather.current_temperature}"
      end

      def lowest_temperature
        "Low: #{weather.todays_lowest_temperature}"
      end

      def weather
        @_weather ||= Weather.new
      end
  end
end
