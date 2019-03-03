require "net/http"

module LifeboxesApi
  class StatusLog
    LOG_API_ENDPOINT = "http://api.thingspeak.com/update"
    LOG_API_KEY = "92YAC5EVJF5ES69W"

    def self.log(*args)
      new(*args).log
    end

    def initialize(values = {})
      @values = values
    end

    def log
      Net::HTTP.post_form(url, post_params)
    end

    private

      attr_reader :values

      def post_params
        { api_key: LOG_API_KEY }.merge(values)
      end

      def url
        URI.parse(LOG_API_ENDPOINT)
      end
  end
end
