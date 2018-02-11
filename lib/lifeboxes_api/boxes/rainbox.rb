require "lifeboxes_api/apis/current_rain"
require "lifeboxes_api/apis/weather"

module LifeboxesApi
  class Rainbox
    SKY_STATES = {
      off: 0,
      slow: 1,
      fast: 2
    }

    def to_json
      {
        states: states,
      }.to_json
    end

    private

      def states
        rain_reports.map do |report|
          case report.rain_intensity
          when :light_rain then SKY_STATES[:slow]
          when :heavy_rain then SKY_STATES[:fast]
          else SKY_STATES[:off]
          end
        end
      end

      def rain_reports
        [current_rain.report] + weather.forecasts
      end


      def weather
        @_weather ||= Weather.new
      end

      def current_rain
        @_current_rain ||= CurrentRain.new
      end
  end
end
