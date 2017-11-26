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

      def messages
        [weather_message, garbage_message].compact
      end

      def weather_message
        {
          title: forecast.description,
          body: "Rain: #{forecast.rain_probability * 100}%"
        }
      end

      def garbage_message
        return unless garbage

        {
          title: "Tomorrow:",
          body: garbage
        }
      end

      def forecast
        @_forecast ||= Forecast.new
      end

      def garbage
        @_garbage ||= Garbage.new(Date.today + 1).run
      end
  end
end
