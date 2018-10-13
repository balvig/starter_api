require "test_helper"

module LifeboxesApi
  class RecycleAssistantTest < Minitest::Test
    def test_to_h
      params = {
        "queryResult" => {
          "parameters" => {
            "date" => "2019-02-27"
          }
        }
      }

      result = RecycleAssistant.new(params).to_h

      assert_equal "Tuesday is combustible garbage", result[:fulfillmentText]
    end

    def test_to_h
      params = {
        "queryResult" => {
          "parameters" => {
            "date" => "2019-02-26"
          },
          "languageCode" => "ja"
        }
      }

      result = RecycleAssistant.new(params).to_h

      assert_equal "月曜日は燃えるゴミの日です", result[:fulfillmentText]
    end
  end
end
