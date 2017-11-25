require "ice_cube"

module StarterApi
  class Garbage
    def initialize(date)
      @date = date
      @rules = {
        "Recyclable" => recyclable,
        "Burnable" => combustible,
        "Non-combustible" => non_combustible,
        "PET bottles" => pet_bottles,
      }
    end

    def run
      find_garbage || "None :)"
    end

    private

      attr_reader :rules, :date

      def find_garbage
        rules.find do |name, rule|
          rule.occurs_on?(date)
        end&.first
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
