require "lifeboxes_api/apis/rain_report"

module LifeboxesApi
  class CurrentRain
    APPLICATION_ID = ENV["YAHOO_APPLICATION_ID"] || raise("Please set YAHOO_APPLICATION_ID")

    def report
      reports.first
    end

    private

      def reports
        rain_data.map do |data|
          RainReport.new(data)
        end
      end

      def rain_data
        data["Feature"].first["Property"]["WeatherList"]["Weather"]
      end

      def data
        JSON.parse(fetch)
      end

      def fetch
        RestClient.get "https://map.yahooapis.jp/weather/V1/place",
          params: {
          coordinates: coordinates,
          output: "json",
          appid: APPLICATION_ID
        }
      end

      def coordinates
        "139.5999187,35.6391694"
      end
  end
end
