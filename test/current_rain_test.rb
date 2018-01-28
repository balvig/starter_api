require "test_helper"

module LifeboxesApi
  class CurrentRainTest < Minitest::Test
    def test_rain_intensity
      current = CurrentRain.new
      assert_equal :light_rain, current.report.rain_intensity
    end

    def test_rainfall
      current = CurrentRain.new
      assert_equal 0, current.report.rainfall
    end
  end
end
