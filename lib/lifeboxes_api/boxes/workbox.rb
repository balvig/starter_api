module LifeboxesApi
  class Workbox
    require "lifeboxes_api/dashboard"

    def initialize(width: 128, height: 250)
      @width = width
      @height = height
    end

    def render
      dashboard.render
    end

    private

      attr_reader :width, :height

      def dashboard
        Dashboard.new(width: width, height: height, widgets: widgets)
      end

      def widgets
        #[prs, reviews, meetings]

        [weather_widget, recycle_widget, github_widget]
      end

      def weather_widget
        {
          title: "Weather",
          header: "#{weather.current.temperature}C",
          footer: "Low: #{weather.lowest_temperature}C"
        }
      end

      def recycle_widget
        {
          title: "Recycling",
          header: recycle_header,
          footer: recycle_footer
        }
      end

      def recycle_header
        garbage.current.to_s.gsub("_", " ").capitalize || "None"
      end

      def recycle_footer
        unless garbage.date == Date.today
          "(tomorrow)"
        end
      end

      def github_widget
        {
          title: "GitHub",
          items: github.statuses.map(&:to_h)
        }
      end



      def prs
        {
          title: "OPEN PRS",
          items: [
            {
              title: "#7458",
              status: "O"
            },
            {
              title: "#834",
              status: "X"
            },
            {
              title: "#2458",
              status: "-"
            }
          ]
        }
      end

      def reviews
        {
          title: "REVIEWS",
          count: 3
        }
      end

      def meetings
        {
          title: "NEXT",
          header: "4:00PM",
          footer: "(in 32 mins)"
        }
      end

      def weather
        @_weather ||= Weather.new
      end

      def garbage
        @_garbage ||= Garbage.new
      end

      def github
        @_github ||= Github.new
      end
  end
end
