require "test_helper"

module LifeboxesApi
  class GithubTest < Minitest::Test
    def test_status
      github = Github.new
      assert_equal ["ci: failure"], github.statuses
    end
  end
end
