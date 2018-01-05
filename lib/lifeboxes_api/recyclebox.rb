require "lifeboxes_api/garbage"
require "lifeboxes_api/servo_degrees"

module LifeboxesApi
  class Recyclebox
    PICKUP_TIME = 9
    CHOICES = Garbage::TYPES.size + 2 # include no gargbage and "off" position

    def to_json
      {
        degrees: degrees
      }.to_json
    end

    private

      def degrees
        ServoDegrees.new(selected, choices: CHOICES).to_i
      end

      def selected
        garbage.to_i + 2 # 0-based index plus "off" position
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
