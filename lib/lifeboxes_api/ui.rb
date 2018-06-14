module LifeboxesApi
  class Ui
    require "lifeboxes_api/cursor"
    require "rmagick"

    def initialize
      @width = 128
      @height = 250
      @canvas = Magick::Image.new(width, height)

      @y = 0
      @x = 0
    end

    def render

      widgets.each_with_index do |widget, i|
        # Start
        widget_y = i * widget_height


        # Title
        cursor.y = widget_y
        cursor.font = :label
        cursor.text widget["title"], linebreak: 1.25

        # -> List
        widget.fetch("items", {}).each do |item|
          msg = item["title"]
          status = item["status"]

          cursor.font = :body
          cursor.text(msg)
          cursor.text(status, x: width - 10, linebreak: 1.5)
        end

        # -> Count
        count = widget["count"]
        if count
          cursor.font = :count
          cursor.text(count.to_s, center: true)
        end

        # Divider
        cursor.y = widget_y + widget_height
        cursor.horizontal_line
      end

      canvas.to_blob { self.format = "jpg" }
    end

    private

      attr_reader :width, :height, :canvas

      def widgets
        @_widgets ||= JSON.parse(Workbox.new.to_json)["widgets"]
      end

      def widget_height
        height / widgets.size
      end

      def cursor
        @_cursor ||= Cursor.new(canvas)
      end
  end
end
