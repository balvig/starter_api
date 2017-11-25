require "test_helper"

module StarterApi
  class GarbageTest < Minitest::Test
    def test_it_does_something_useful
      garbage = Garbage.new
      assert_equal :none, garbage.today
    end
  end
end
