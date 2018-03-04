require "lifeboxes_api/apis/mahalojournal"

module LifeboxesApi
  class Inspirebox
    def to_json
      {
        text: random_mahalo_journal_entry
      }.to_json
    end

    private

      def random_mahalo_journal_entry
        Mahalojournal.new.random
      end
  end
end
