require "starter_api/forecast"
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
        [0, 0, 0]
      end

      def garbage_leds
        garbage.map do |type, active|
          active ? 1 : 0
        end
      end

      def garbage
        @_garbage ||= Garbage.new(Date.today + 6).run
      end
  end
end
