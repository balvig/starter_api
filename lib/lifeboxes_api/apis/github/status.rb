module LifeboxesApi
  class Github
      class Status
        def initialize(data)
          @data = data
        end

        def to_s
          "#{context}: #{result}"
        end

        def to_h
          {
            title: context,
            status: result
          }
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
