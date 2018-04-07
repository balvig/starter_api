require "net/http"
require "json"
require "lifeboxes_api/apis/mahalojournal/entry"

module LifeboxesApi
  module Mahalojournal
    class Api
      URL = "http://www.mahalojournal.com/item"

      def random
        Entry.new(data)
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
end
