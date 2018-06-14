module LifeboxesApi
  class Cursor
    require "rmagick"

    attr_accessor :y, :font
    attr_reader :x

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

    def text(text, center: false)
      commit do
        text_x = x
        text_y = y + line_height

        if center
          draw.text_align(Magick::CenterAlign)
          text_x = width / 2
        end

        draw.text(text_x, text_y, text)
      end
    end

    def linebreak(factor)
      move_down line_height(factor)
    end

    def horizontal_line
      commit do
        draw.line(0, y, width, y)
      end
    end

    def x=(new_x)
      if new_x < 0
        @x = width + new_x
      else
        @x = new_x
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

      def move_down(distance)
        @y += distance
      end

      def line_height(factor = 1)
        draw.get_type_metrics("A").height * factor
      end
  end
end