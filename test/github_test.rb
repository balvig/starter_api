require "test_helper"

module LifeboxesApi
  class GithubTest < Minitest::Test
    def test_status
      github = Github.new
      assert_equal ["ci: failure"], github.statuses
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
