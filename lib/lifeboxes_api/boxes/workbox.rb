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
        [prs, reviews, meetings]
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
  end
end
