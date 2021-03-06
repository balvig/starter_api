require "lifeboxes_api/apis/garbage"
require "lifeboxes_api/cycles"
require "lifeboxes_api/servo_degrees"
require "lifeboxes_api/status_log"

module LifeboxesApi
  class Recyclebox < Lifebox
    DEFAULT_LOG_API_KEY = "92YAC5EVJF5ES69W"
    PICKUP_TIME = 9
    CHOICES = [:off, :nothing] + Garbage::TYPES
    LOW_BATTERY_LEVEL = 780

    def process
      write_log
    end

    def to_h
      {
        degrees: degrees,
        cycles: remaining_cycles
      }
    end

    private

      def write_log
        StatusLog.log(
          api_key: log_api_key,
          field1: battery_level,
          field2: degrees,
          field3: remaining_cycles
        )
      end

      def battery_level
        params[:battery_level]&.to_i
      end

      def log_api_key
        custom_log_key || DEFAULT_LOG_API_KEY
      end

      def custom_log_key
        params[:log_key]
      end

      def degrees
        ServoDegrees.new(current_index, choices: CHOICES.size).to_i
      end

      def current_index
        CHOICES.index(current)
      end

      def current
        if low_battery?
          :off
        else
          garbage.current || :nothing
        end
      end

      def low_battery?
        battery_level && battery_level <= LOW_BATTERY_LEVEL
      end

      def garbage
        @_garbage ||= Garbage.new(date)
      end

      def remaining_cycles
        Cycles.until(now: current_hour, target: PICKUP_TIME)
      end

      def current_hour
        Time.now.hour
      end

      def date
        if current_hour >= PICKUP_TIME
          Date.today + 1
        else
          Date.today
        end
      end
  end
end
