module LifeboxesApi
  class Lifebox
    def initialize(params = {})
      @params = params
    end

    def process
      # noop - override to do some logging etc
    end

    private

      attr_reader :params
  end
end
