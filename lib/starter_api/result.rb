require "starter_api/forecast"
require "starter_api/garbage"

module StarterApi
  class Result
    def to_json
      {
        status: status,
        messages: messages
      }.to_json
    end

    private

      def status
        if value.nil?
          nil
        elsif value >= 0.7
          :red
        elsif value >= 0.4
          :yellow
        else
          :green
        end
      end

      def value
        forecast.rain_probability
      end

      def forecast
        @_forecast ||= Forecast.new
      end

      def messages
        [weather_message, garbage_message]
      end

      def weather_message
        {
          title: forecast.description.capitalize,
          body: "Rain: #{forecast.rain_probability * 100}%"
        }
      end

      def garbage_message
        {
          title: "Garbage tmrw:",
          body: Garbage.new(Date.today + 1).run
        }
      end
  end
end
