module LifeboxesApi
  class Inspirebox
    URL = "http://www.mahalojournal.com/item"
    require "net/http"
    require "json"

    def to_json
      {
        text: random_mahalo_journal_entry
      }.to_json
    end

    private

      def random_mahalo_journal_entry
        JSON.parse(json_response)["title"]
      end

      def json_response
        Net::HTTP.get URI(URL)
      end
  end
end
