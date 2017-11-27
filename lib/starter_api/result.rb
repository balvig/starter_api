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
        if rain_probability >= 70
          :red
        elsif rain_probability >= 40
          :blue
        else
          :white
        end
      end

      def rain_probability
        forecast.rain_probability
      end

      def messages
        [weather_message, garbage_message].compact
      end

      def weather_message
        {
          title: forecast.summary.capitalize,
          body: "#{forecast.temperature}C / #{rain_probability}%"
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
