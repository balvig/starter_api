module LifeboxesApi
  class Cursor
    require "rmagick"

    attr_accessor :x, :y, :font

    FONTS = {
      body: ["FreeMono", 12],
      label: ["FreeMonoBold", 12],
      count: ["Lato-Semibold", 36],
      header: ["Lato-Semibold", 24]
    }

    def initialize(canvas)
      @canvas = canvas
      @x = 0
      @y = 0
    end

    def text(text, x: 0, center: false, linebreak: false)
      commit do
        text_x = x
        text_y = y + line_height

        if center
          draw.text_align(Magick::CenterAlign)
          text_x = width / 2
        end

        draw.text(text_x, text_y, text)

        if linebreak
          move_down line_height(linebreak)
        end
      end
    end

    def horizontal_line
      commit do
        draw.line(0, y, width, y)
      end
    end

    private

      attr_reader :canvas, :draw

      def commit(&block)
        new_drawing
        yield
        draw.draw(canvas)
      end

      def width
        canvas.columns
      end

      def height
        canvas.rows
      end

      def new_drawing
        @draw = Magick::Draw.new
        settings = FONTS[font]
        @draw.font = "fonts/#{settings.first}.ttf"
        @draw.pointsize = settings.last
      end

      def move_to(x: nil, y: nil)
        @y = y if y
        @x = x if x
      end

      def move_down(distance)
        @y += distance
      end

      def line_height(factor = 1)
        draw.get_type_metrics("A").height * factor
      end
  end
end
