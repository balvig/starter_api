module LifeboxesApi
  class Dashboard
    require "rmagick"
    require "lifeboxes_api/dashboard/widget"

    def initialize(width:, height:, widgets:)
      @width = width
      @height = height
      @widgets = widgets
    end

    def render
      widgets.each_with_index do |data, i|
        Widget.new(data: data, canvas: canvas, y: i * widget_height, height: widget_height).draw
      end

      canvas.to_blob { self.format = "png" }
    end

    private

      attr_reader :width, :height, :widgets

      def canvas
        @_canvas ||= Magick::Image.new(width, height)
      end

      def widget_height
        height / widgets.size
      end
  end
end
