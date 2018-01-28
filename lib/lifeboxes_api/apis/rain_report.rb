module LifeboxesApi
  class RainReport
    def initialize(data)
      @data = data
    end

    def rain_intensity
      if rainfall > 2
        :heavy_rain
      elsif rainfall > 0.5
        :light_rain
      end
    end

    def rainfall
      data["Rainfall"]
    end

    private

      attr_reader :data
  end
end
