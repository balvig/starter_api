lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require "bundler"

#Bundler.require :default, ENV["RACK_ENV"].to_sym

require "sinatra"
require "lifeboxes_api"

get "/work" do
  require "lifeboxes_api/ui"
  content_type "image/jpeg"
  LifeboxesApi::Ui.new.render
end

get "/:box" do
  content_type :json

  begin
    box.new.to_json
  rescue NameError
    status 404
    { error: "not_found"}.to_json
  end
end

private

  def box
    Object.const_get(box_name)
  end

  def box_name
    "LifeboxesApi::#{params[:box].capitalize}box"
  end
