require "octokit"

module LifeboxesApi
  class Github
    REPO = "cookpad/global-web"
    REF = "heads/master"

    def statuses
      status_data.map do |data|
        Status.new(data).to_s
      end
    end

    private

      def status_data
        Octokit.combined_status(REPO, REF).statuses
      end

      class Status
        def initialize(data)
          @data = data
        end

        def to_s
          "#{context}: #{result}"
        end

        private

          attr_accessor :data

          def result
            case data.state
            when "success"
              "OK"
            when "failure"
              "X"
            else
              "-"
            end
          end

          def context
            data.context.split("/").first
          end
      end
  end
end
