require "net/http"

module LifeboxesApi
  class StatusLog
    LOG_API_ENDPOINT = "http://api.thingspeak.com/update"
    LOG_API_KEY = "92YAC5EVJF5ES69W"

    def log(value)
      Net::HTTP.post_form(url, field1: value, api_key: LOG_API_KEY)
    end

    private

      def url
        URI.parse(LOG_API_ENDPOINT)
      end
  end
end
