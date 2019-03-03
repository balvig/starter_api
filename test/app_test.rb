require "test_helper"
require "rack/test"
require "./app"
require "awesome_print"

module LifeboxesApi
  class AppTest < Minitest::Test
    include Rack::Test::Methods

    def test_boxes
      %w(kitchen rain recycle status).each do |box|
        test_box box
      end
    end

    def test_work_box
      get "/work"

      assert last_response.ok?
    end

    private

      def app
        Sinatra::Application
      end

      def test_box(box)
        puts "<< Testing #{box} >>"
        get box

        assert last_response.ok?
        ap JSON.parse(last_response.body)
      end
  end
end
