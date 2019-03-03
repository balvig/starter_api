lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require "bundler"

#Bundler.require :default, ENV["RACK_ENV"].to_sym

require "sinatra"
require "lifeboxes_api"
require "json"

set :raise_errors, true
set :show_exceptions, false

post "/recycle_assistant" do
  LifeboxesApi::RecycleAssistant.new(json).to_h.to_json
end

get "/work" do
  content_type "image/jpeg"
  LifeboxesApi::Workbox.new.render
end

get "/:box" do
  content_type :json

  box = box_class.new(params)
  box.process
  box.to_h.to_json
end

private

  def box_class
    Object.const_get(box_name)
  rescue NameError
    status 404
    { error: "not_found" }.to_json
  end

  def box_name
    "LifeboxesApi::#{params[:box].capitalize}box"
  end

  def json
    request.body.rewind
    JSON.parse(request.body.read)
  end
