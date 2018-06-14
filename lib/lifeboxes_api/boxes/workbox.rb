module LifeboxesApi
  class Workbox
    def to_json
      {
        widgets: widgets
      }.to_json
    end

    private

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
