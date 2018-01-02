require "test_helper"

module LifeboxesApi
  class GarbageTest < Minitest::Test
    def test_to_i_for_pet_bottle_date
      garbage = Garbage.new Date.new(2018, 1, 9)
      assert_equal 2, garbage.to_i
    end

    def test_to_i_for_no_garbage_date
      garbage = Garbage.new Date.new(2018, 1, 7)
      assert_equal 0, garbage.to_i
    end
  end
end
