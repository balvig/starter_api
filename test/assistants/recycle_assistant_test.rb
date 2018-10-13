require "test_helper"

module LifeboxesApi
  class RecycleAssistantTest < Minitest::Test
    def test_to_h_en
      params = {
        "queryResult" => {
          "parameters" => {
            "date" => "2019-02-27"
          },
          "languageCode" => "en-us"
        }
      }

      result = RecycleAssistant.new(params).to_h

      assert_equal "Wednesday is non-combustible garbage", result[:fulfillmentText]
    end

    def test_to_h_japanese
      params = {
        "queryResult" => {
          "parameters" => {
            "date" => "2019-02-26"
          },
          "languageCode" => "ja"
        }
      }

      result = RecycleAssistant.new(params).to_h

      assert_equal "火曜日は燃えるゴミの日です", result[:fulfillmentText]
    end
  end
end
