require "lifeboxes_api/apis/garbage"

module LifeboxesApi
  class RecycleAssistant
    CHOICES = [:off, :nothing] + Garbage::TYPES

    def initialize(params)
      @params = params
    end

    def to_h
      {
        fulfillmentText: response
      }
    end

    private

      attr_reader :params

      def response
        if garbage.current
          I18n.t "recycle_assistant.garbage", date: human_date, type: I18n.t("recycle_assistant.types.#{garbage.current}")
        else
          I18n.t "recycle_assistant.nothing", date: human_date
        end
      end

      def date
        Date.parse params["queryResult"]["parameters"]["date"]
      end

      def human_date
        date.strftime("%A")
      end

      def garbage
        @_garbage ||= Garbage.new(date)
      end
  end
end
