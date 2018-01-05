module LifeboxesApi
  class ServoDegrees
    TOTAL_DEGREES = 180

    def initialize(selected, choices: 5)
      @selected = selected
      @choices = choices
    end

    def to_i
      TOTAL_DEGREES - degrees_to_subtract
    end

    private

      attr_reader :selected, :choices

      def degrees_to_subtract
        current_segment * degrees_per_selection
      end

      def degrees_per_selection
        TOTAL_DEGREES / segments
      end

      def current_segment
        selected - 1
      end

      def segments
        choices - 1
      end

      def degrees
        result = 180
        garbage.results.values.each_with_index do |active, index|
          if active
            result -= (index + 1) * 45
          end
        end
        result + OFFSET
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
