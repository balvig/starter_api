require "lifeboxes_api/garbage"

module LifeboxesApi
  class Recyclebox
    PICKUP_TIME = 9
    OFFSET = 5

    def to_json
      {
        degrees: degrees
      }.to_json
    end

    private

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
