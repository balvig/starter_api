lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require "bundler"

#Bundler.require :default, ENV["RACK_ENV"].to_sym

require "sinatra"
require "starter_api"

get "/lifebox" do
  content_type :json
  StarterApi::Lifebox.new.to_json
end
