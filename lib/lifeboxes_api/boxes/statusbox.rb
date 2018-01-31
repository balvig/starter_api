require "lifeboxes_api/apis/weather_forecast"

module LifeboxesApi
  class Statusbox
    BORDER = "----------"

    def to_json
      {
        screens: screens
      }.to_json
    end

    private

      def screens
        [
          temperature_screen,
          weather_codes_screen,
          recycle_screen,
        ]
      end

      def temperature_screen
        <<~TEXT
        #{day.upcase}
        #{BORDER}
        Now: #{current_weather.temperature}C
        Low: #{lowest_temperature}C
        TEXT
      end

      def weather_codes_screen
        <<~TEXT
        WEATHER
        #{BORDER}
        #{weather_codes}
        TEXT
      end

      def weather_codes
        weather.reports.map do |report|
          "#{report.time.strftime("%k:%M")} #{report.code}"
        end.join("\n")
      end

      def recycle_screen
        <<~TEXT
        RECYCLING
        #{BORDER}
        #{garbage.current || "No garbage"}
        TEXT
      end

      def day
        Date.today.strftime("%A")
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
