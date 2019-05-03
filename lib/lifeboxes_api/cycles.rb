module LifeboxesApi
  class Cycles
    HOURS_IN_DAY = 24

    def self.until(*args)
      new(*args).until
    end

    def initialize(now:, target:)
      @now = now
      @target = target
    end

    def until
      if target > now
        target - now
      else
        HOURS_IN_DAY - (now - target)
      end
    end

    private

      attr_reader :now, :target
  end
end
