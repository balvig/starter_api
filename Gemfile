ruby "2.4.5"
source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "dotenv"
gem "facets"
gem "i18n"
gem "ice_cube"
gem "octokit"
gem "open-weather-api", github: "wikiti/open-weather-api-rb", branch: "fix-parameters-management"
gem "sinatra"
gem "rmagick"

group :development do
  gem "pry"
  gem "rerun"
end

group :test do
  gem "awesome_print"
  gem "minitest"
  gem "rack-test"
end
