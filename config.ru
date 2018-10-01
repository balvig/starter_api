$stdout.sync = true # https://devcenter.heroku.com/articles/logging#writing-to-your-log
require "./app"
run Sinatra::Application
