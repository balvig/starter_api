require "test_helper"

module LifeboxesApi
  class ServoDegreesTest < Minitest::Test
    def test_default_of_five_choices
      assert_equal 180, ServoDegrees.new(0).to_i
      assert_equal 135, ServoDegrees.new(1).to_i
      assert_equal 90, ServoDegrees.new(2).to_i
      assert_equal 45, ServoDegrees.new(3).to_i
      assert_equal 0, ServoDegrees.new(4).to_i
    end

    def test_six_choices
      assert_equal 0, ServoDegrees.new(5, choices: 6).to_i
      assert_equal 180, ServoDegrees.new(0, choices: 6).to_i
    end
  end
end
