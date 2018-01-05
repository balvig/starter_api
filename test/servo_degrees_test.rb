require "test_helper"

module LifeboxesApi
  class ServoDegreesTest < Minitest::Test
    def test_default_of_five_choices
      assert_equal 185, ServoDegrees.new(1).to_i
      assert_equal 140, ServoDegrees.new(2).to_i
      assert_equal 95, ServoDegrees.new(3).to_i
      assert_equal 50, ServoDegrees.new(4).to_i
      assert_equal 5, ServoDegrees.new(5).to_i
    end

    def test_six_choices
      assert_equal 5, ServoDegrees.new(6, choices: 6).to_i
      assert_equal 185, ServoDegrees.new(1, choices: 6).to_i
    end
  end
end
