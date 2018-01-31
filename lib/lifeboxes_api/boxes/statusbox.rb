require "lifeboxes_api/apis/weather_forecast"

module LifeboxesApi
  class Statusbox
    def to_json
      {
        screens: screens
      }.to_json
    end

    private

      def screens
        [
          temperature_screen,
          recycle_screen,
          other_debug_screen
        ]
      end

      def temperature_screen
        <<~TEXT
        #{day}
        ---
        High: #{current_weather.temperature}C
        Low: #{lowest_temperature}C

        (#{last_update})
        TEXT
      end

      def recycle_screen
        <<~TEXT
        Recycling
        ---
        #{garbage.current || "No garbage"}
        TEXT
      end

      def other_debug_screen
        "Word"
      end

      def day
        Date.today.strftime("%A")
      end

      def last_update
        Time.now.strftime("%k:%M")
      end

      def temperatures
        [current_weather_message, lowest_temperature_message]
      end

      def lowest_temperature
        all_lowest_temperatures.min
      end

      def all_lowest_temperatures
        ([current_weather] + forecasts).map(&:lowest_temperature)
      end

      def current_weather
        weather.current
      end

      def forecasts
        weather.reports
      end

      def weather
        @_weather ||= WeatherForecast.new
      end

      def garbage
        @_garbage ||= Garbage.new
      end
  end
end
