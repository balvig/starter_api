module LifeboxesApi
  class Widget
    require "lifeboxes_api/cursor"

    def initialize(data:, canvas:, y:, height:)
      @data = data
      @canvas = canvas
      @y = y
      @height = height
    end

    def draw
      draw_title
      draw_list
      draw_count
      draw_divider
    end

    private

      attr_reader :data, :canvas, :y, :height

      def draw_title
        cursor.y = y
        cursor.font = :label
        cursor.text data["title"]
        cursor.linebreak(1.25)
      end

      def draw_list
        data.fetch("items", {}).each do |item|
          title = item["title"]
          status = item["status"]

          cursor.font = :body
          cursor.text(title)
          cursor.x = -10
          cursor.text(status)
          cursor.linebreak(1.5)
          cursor.x = 0
        end
      end

      def draw_count
        count = data["count"]
        if count
          cursor.font = :count
          cursor.text(count.to_s, center: true)
        end
      end

      def draw_divider
        cursor.y = y + height
        cursor.horizontal_line
      end

      def cursor
        @_cursor ||= Cursor.new(canvas)
      end
  end
end