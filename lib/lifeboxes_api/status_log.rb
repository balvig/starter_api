require "net/http"

module LifeboxesApi
  class StatusLog
    LOG_API_ENDPOINT = "http://api.thingspeak.com/update"

    def self.log(*args)
      new(*args).log
    end

    def initialize(api_key:, **values)
      @api_key = api_key
      @values = values
    end

    def log
      Net::HTTP.post_form(url, post_params)
    end

    private

      attr_reader :api_key, :values

      def post_params
        { api_key: api_key }.merge(values)
      end

      def url
        URI.parse(LOG_API_ENDPOINT)
      end
  end
end
