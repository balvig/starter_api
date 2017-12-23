require "ice_cube"

module StarterApi
  class Garbage
    TYPES = %i(recyclable combustible non_combustible pet_bottles)

    def initialize(date)
      @date = date
    end

    def run
      results
    end

    private

      attr_reader :date

      def results
        TYPES.inject({}) do |result, type|
          result.merge(type => garbage_day?(type))
        end
      end

      def garbage_day?(type)
        rule = send(type)
        rule.occurs_on?(date)
      end

      # Rules
      def recyclable
        build_schedule do |schedule|
          schedule.weekly.day(:monday)
        end
      end

      def combustible
        build_schedule do |schedule|
          schedule.weekly.day(%i(tuesday friday))
        end
      end

      def non_combustible
        build_schedule do |schedule|
          schedule.monthly.day_of_week(wednesday: [2, 4])
        end
      end

      def pet_bottles
        build_schedule do |schedule|
          schedule.monthly.day_of_week(wednesday: [1, 3])
        end
      end

      def build_schedule
        schedule = IceCube::Schedule.new
        schedule.add_recurrence_rule yield(IceCube::Rule)
        schedule
      end
  end
end
