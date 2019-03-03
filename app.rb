lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require "bundler"

#Bundler.require :default, ENV["RACK_ENV"].to_sym

require "sinatra"
require "lifeboxes_api"
require "lifeboxes_api/status_log"
require "json"

set :show_exceptions, false

error 500 do
  error = env["sinatra.error"]
  { error: "#{error.class}: #{error.message}" }.to_json
end

post "/recycle_assistant" do
  LifeboxesApi::RecycleAssistant.new(json).to_h.to_json
end

get "/work" do
  content_type "image/jpeg"
  LifeboxesApi::Workbox.new.render
end

get "/:box" do
  content_type :json

  begin
    box = box_class.new(params)
    box.process
    box.to_h.to_json
  rescue NameError
    status 404
    { error: "not_found" }.to_json
  end
end

after do
  if log_value
    LifeboxesApi::StatusLog.new.log(log_value)
  end
end

private

  def box_class
    Object.const_get(box_name)
  end

  def box_name
    "LifeboxesApi::#{params[:box].capitalize}box"
  end

  def log_value
    params[:log_value]
  end

  def json
    request.body.rewind
    JSON.parse(request.body.read)
  end
