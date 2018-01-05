require "test_helper"

module LifeboxesApi
  class GarbageTest < Minitest::Test
    def test_current_for_combustible_date
      garbage = Garbage.new Date.new(2018, 1, 9)
      assert_equal :combustible, garbage.current
    end

    def test_current_for_no_garbage_date
      garbage = Garbage.new Date.new(2018, 1, 7)
      assert_nil garbage.current
    end

    def test_current_for_beginning_of_year
      garbage = Garbage.new Date.new(2018, 1, 3)
      assert_nil garbage.current
    end
  end
end
