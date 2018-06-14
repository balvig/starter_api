module LifeboxesApi
  class Ui
    require "rmagick"
    require "lifeboxes_api/widget"

    def initialize
      @width = 128
      @height = 250
      @canvas = Magick::Image.new(width, height)
    end

    def render
      widgets.each_with_index do |data, i|
        Widget.new(data: data, canvas: canvas, y: i * widget_height, height: widget_height).draw
      end

      canvas.to_blob { self.format = "png" }
    end

    private

      attr_reader :width, :height, :canvas

      def widgets
        @_widgets ||= JSON.parse(Workbox.new.to_json)["widgets"]
      end

      def widget_height
        height / widgets.size
      end
  end
end
