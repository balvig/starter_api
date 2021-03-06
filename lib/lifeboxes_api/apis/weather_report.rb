require "yaml"

module LifeboxesApi
  class WeatherReport
    WEATHER_CODES = YAML::load_file(File.join(__dir__, "weather_codes.yml"))

    def initialize(data)
      @data = data
    end

    def time
      Time.at(timestamp)
    end

    def rain_intensity
      WEATHER_CODES.find do |name, codes|
        codes.include?(code)
      end&.first&.to_sym
    end

    def code
      data["weather"].first["id"]
    end

    def temperature
      data["main"]["temp"].round
    end

    def lowest_temperature
      data["main"]["temp_min"].round
    end

    private

      attr_reader :data

      def timestamp
        data["dt"]
      end
  end
end
