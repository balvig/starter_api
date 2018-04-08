require "facets/string/word_wrap"

module LifeboxesApi
  class Linebreaker
    MAX_CHARS_PER_LINE = 33

    def initialize(text)
      @text = text
    end

    def run
      text_with_linebreaks
    end

    private

      attr_reader :text

      def text_with_linebreaks
        text.word_wrap(MAX_CHARS_PER_LINE).chomp
      end
  end
end
