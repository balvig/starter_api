require "net/http"
    require "json"

module LifeboxesApi
  class Mahalojournal
    URL = "http://www.mahalojournal.com/item"

    def random
      data["title"]
    end

    private

      def data
        JSON.parse(response)
      end

      def uri
        URI(URL)
      end

      def response
        Net::HTTP.get(uri)
      end
  end
end
