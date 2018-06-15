module LifeboxesApi
  class Dashboard
    class Widget
      require "lifeboxes_api/dashboard/cursor"

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
        draw_header
        draw_footer
        draw_divider
      end

      private

        attr_reader :data, :canvas, :y, :height

        def draw_title
          cursor.y = y
          cursor.font = :label
          cursor.text data[:title].upcase
          cursor.linebreak(1.25)
        end

        def draw_list
          data.fetch(:items, []).each do |item|
            title = item[:title]
            status = item[:status]

            cursor.font = :body
            cursor.linebreak(0.25)
            cursor.text(title)
            cursor.text(status, align: :right)
            cursor.linebreak(1.25)
          end
        end

        def draw_count
          count = data[:count]
          if count
            cursor.font = :count
            cursor.text(count.to_s, align: :center)
          end
        end

        def draw_header
          header = data[:header]
          if header
            cursor.font = :header
            cursor.linebreak(0.25)
            cursor.text(header, align: :center)
            cursor.linebreak(1.1)
          end
        end

        def draw_footer
          footer = data[:footer]
          if footer
            cursor.font = :body
            cursor.text(footer, align: :center)
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
end
