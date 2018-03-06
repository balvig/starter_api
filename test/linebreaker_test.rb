require "test_helper"

module LifeboxesApi
  class LinebreakerTest < Minitest::Test
    def test_linebreaking_1
      result = Linebreaker.new("The simple fun of blowing easter eggs without having to worry about salmonella").run

      assert_equal "The simple fun of blowing easter\neggs without having to worry about\nsalmonella", result
    end

    def test_linebreaking_2
      result = Linebreaker.new("Was able to spend a relaxing Sunday").run

      assert_equal "Was able to spend a relaxing\nSunday", result
    end
  end
end
