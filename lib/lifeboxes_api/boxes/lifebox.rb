module LifeboxesApi
  class Lifebox
    def initialize(params = {})
      @params = params
    end

    private

      attr_reader :params
  end
end
