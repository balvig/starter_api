require "lifeboxes_api/weather"
require "lifeboxes_api/garbage"

module LifeboxesApi
  class Kitchenbox
    PICKUP_TIME = 9

    def to_json
      {
        led_values: led_values
      }.to_json
    end

    def to_s
      led_values.join(",")
    end

    private

      def led_values
        weather_leds + garbage_leds
      end

      def weather_leds
        weather.forecast.map do |report|
          case report.rain_intensity
          when :light_rain then 2
          when :heavy_rain then 1
          else 0
          end
        end
      end

      def garbage_leds
        garbage.results.map do |type, active|
          active ? 1 : 0
        end
      end

      def weather
        @_weather ||= Weather.new
      end

      def garbage
        @_garbage ||= Garbage.new(garbage_date)
      end

      def garbage_date
        if Time.now.hour >= PICKUP_TIME
          Date.today + 1
        else
          Date.today
        end
      end
  end
end
