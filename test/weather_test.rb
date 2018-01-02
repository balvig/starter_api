require "test_helper"

module LifeboxesApi
  class WeatherTest < Minitest::Test
    def test_it_works
      weather = Weather.new
      assert_equal weather.forecast.last.rain_intensity, :light_rain
    end
  end
end
