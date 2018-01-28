lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require "bundler"

#Bundler.require :default, ENV["RACK_ENV"].to_sym

require "sinatra"
require "lifeboxes_api"

get "/rain" do
  content_type :json
  LifeboxesApi::Rainbox.new.to_json
end

get "/recycle" do
  content_type :json
  LifeboxesApi::Recyclebox.new.to_json
end

get "/kitchen" do
  content_type :json
  LifeboxesApi::Kitchenbox.new.to_json
end
