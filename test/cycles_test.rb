require "test_helper"

module LifeboxesApi
  class CyclesTest < Minitest::Test
    def test_until_after_target
      assert_equal 20, Cycles.until(now: 13, target: 9)
    end

    def test_until_before_target
      assert_equal 1, Cycles.until(now: 8, target: 9)
    end
  end
end
