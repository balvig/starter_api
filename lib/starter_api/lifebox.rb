require "starter_api/weather"
require "starter_api/garbage"

module StarterApi
  class Lifebox
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
        garbage.map do |type, active|
          active ? 1 : 0
        end
      end

      def weather
        @_weather ||= Weather.new
      end

      def garbage
        @_garbage ||= Garbage.new(Date.today + 1).run
      end
  end
end
