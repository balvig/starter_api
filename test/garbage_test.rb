require "test_helper"

module StarterApi
  class GarbageTest < Minitest::Test
    def test_it_works
      garbage = Garbage.new Date.new(2017, 12, 22)
      # require 'pry'; binding.pry
    end
  end
end
