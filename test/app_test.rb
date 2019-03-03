require "test_helper"
require "rack/test"
require "./app"

module LifeboxesApi
  class AppTest < Minitest::Test
    include Rack::Test::Methods

    def test_kitchen_box
      get "/kitchen"

      assert last_response.ok?
    end

    def test_rain_box
      get "/rain"

      assert last_response.ok?
    end

    def test_recycle_box
      get "/recycle"

      assert last_response.ok?
    end

    def test_status_box
      get "/status"

      assert last_response.ok?
    end

    def test_work_box
      get "/work"

      assert last_response.ok?
    end

    def app
      Sinatra::Application
    end

  end
end
