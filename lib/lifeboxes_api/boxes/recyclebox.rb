require "lifeboxes_api/apis/garbage"
require "lifeboxes_api/servo_degrees"
require "lifeboxes_api/status_log"

module LifeboxesApi
  class Recyclebox < Lifebox
    CHOICES = [:off, :nothing] + Garbage::TYPES

    def process
      write_log
    end

    def to_h
      {
        degrees: degrees
      }
    end

    private

      def write_log
        StatusLog.log(
          field1: battery_level,
          field2: degrees
        )
      end

      def battery_level
        params[:log_value]
      end

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
        @_garbage ||= Garbage.new
      end
  end
end
