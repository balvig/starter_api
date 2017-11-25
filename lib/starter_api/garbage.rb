require "ice_cube"

module StarterApi
  class Garbage
    def initialize
      @rules = {
        recyclable: recyclable,
        combustible: combustible,
        non_combustible: non_combustible,
        pet_bottles: pet_bottles,
      }
    end

    def today
      find_todays_garbage
    end

    private

      attr_reader :rules

      def find_todays_garbage
        rules.find do |name, rule|
          rule.occurs_on?(Date.today)
        end
      end

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
