module LifeboxesApi
  module Mahalojournal
    class Entry
      def initialize(data)
        @data = data
      end

      def text
        data["title"]
      end

      def date
        Date.parse data["created_at"]
      end

      private

        attr_reader :data
    end
  end
end
