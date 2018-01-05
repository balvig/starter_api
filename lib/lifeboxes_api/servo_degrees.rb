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
        selected * degrees_per_selection
      end

      def degrees_per_selection
        TOTAL_DEGREES / segments
      end

      def segments
        choices - 1
      end
  end
end
