module LifeboxesApi
  class Github
    require "octokit"
    require "lifeboxes_api/apis/github/status"

    REPO = "cookpad/global-web"
    REF = "heads/master"

    def statuses
      status_data.map do |data|
        Status.new(data)
      end
    end

    private

      def status_data
        Octokit.combined_status(REPO, REF).statuses
      end
  end
end
