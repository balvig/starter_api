ruby "2.4.2"
source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "dotenv"
gem "ice_cube"
gem "octokit"
gem "open-weather-api", github: "wikiti/open-weather-api-rb", branch: "fix-parameters-management"
gem "sinatra"

group :development do
  gem "pry"
end

group :test do
  gem "minitest"
end
