require "lifeboxes_api/apis/garbage"
require "lifeboxes_api/servo_degrees"

module LifeboxesApi
  class Recyclebox < Lifebox
    CHOICES = [:off, :nothing] + Garbage::TYPES

    def to_h
      {
        degrees: degrees
      }
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
        @_garbage ||= Garbage.new
      end
  end
end
