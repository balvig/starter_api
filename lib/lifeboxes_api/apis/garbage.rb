require "ice_cube"

module LifeboxesApi
  class Garbage
    TYPES = %i(recyclable combustible pet_bottles non_combustible)

    attr_reader :date

    def initialize(date = Date.today)
      @date = date
    end

    def current
      TYPES.find do |type|
        garbage_day?(type)
      end
    end

    private

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

      def new_year_break
        IceCube::Rule.yearly.day_of_year(1, 3)
      end

      def build_schedule
        schedule = IceCube::Schedule.new(date)
        schedule.add_recurrence_rule yield(IceCube::Rule)
        schedule.add_exception_rule(new_year_break)
        schedule
      end
  end
end
