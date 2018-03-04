require "lifeboxes_api/apis/mahalojournal"
require "lifeboxes_api/linebreaker"

module LifeboxesApi
  class Inspirebox
    def to_json
      {
        text: formatted_text
      }.to_json
    end

    private

      def formatted_text
        Linebreaker.new(random_mahalo_journal_entry).run
      end

      def random_mahalo_journal_entry
        Mahalojournal.new.random
      end
  end
end
