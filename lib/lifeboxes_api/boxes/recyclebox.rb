require "lifeboxes_api/apis/garbage"
require "lifeboxes_api/servo_degrees"

module LifeboxesApi
  class Recyclebox
    PICKUP_TIME = 9
    CHOICES = [:off, :nothing] + Garbage::TYPES

    def to_json
      {
        degrees: degrees
      }.to_json
    end

    private

      def degrees
        ServoDegrees.new(current_index, choices: CHOICES.size).to_i
      end

      def current_index
        CHOICES.index(current)
      end

      def current
        garbage.current || :nothing
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
