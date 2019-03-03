require "test_helper"

module LifeboxesApi
  class WeatherTest < Minitest::Test
    def test_rain_intensity
      weather = Weather.new
      assert_equal :light_rain, weather.forecasts.first.rain_intensity
    end

    #def test_current_temperature
      #weather = Weather.new
      #assert_equal 6, weather.current_temperature
    #end

    #def test_todays_lowest_temperature
      #weather = Weather.new
      #assert_equal 5, weather.todays_lowest_temperature
    #end
  end
end
