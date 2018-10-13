require "test_helper"

module LifeboxesApi
  class RecycleAssistantTest < Minitest::Test
    def test_to_h
      params = {
        "queryResult" => {
          "parameters" => {
            "date" => "2018-02-27"
          }
        }
      }

      result = RecycleAssistant.new(params).to_h

      assert_equal "There is no recycling for Tuesday", result[:fulfillmentText]
    end
  end
end
