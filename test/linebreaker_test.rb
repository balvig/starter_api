require "test_helper"

module LifeboxesApi
  class LinebreakerTest < Minitest::Test
    def test_linebreaking
      result = Linebreaker.new("The simple fun of blowing easter eggs without having to worry about salmonella").run

      assert_equal "The simple fun of blowing easter\neggs without having to worry about\nsalmonella", result
    end
  end
end
