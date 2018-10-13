require "lifeboxes_api/apis/garbage"

module LifeboxesApi
  class RecycleAssistant
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
          t "recycle_assistant.garbage", date: human_date, type: t("recycle_assistant.types.#{garbage.current}")
        else
          t "recycle_assistant.nothing", date: human_date
        end
      end

      def t(key, interpolations = {})
        I18n.t key, interpolations.merge(locale: current_locale)
      end

      def current_locale
        params["queryResult"]["languageCode"].split("-").first
      end

      def human_date
        I18n.l date, format: :day, locale: current_locale
      end

      def date
        Date.parse params["queryResult"]["parameters"]["date"]
      end

      def garbage
        @_garbage ||= Garbage.new(date)
      end
  end
end
