lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require "bundler"

#Bundler.require :default, ENV["RACK_ENV"].to_sym

require "sinatra"
require "lifeboxes_api"

get "/:box" do
  content_type :json
  box.new.to_json
end

private

  def box
    Object.const_get(box_name)
  end

  def box_name
    "LifeboxesApi::#{params[:box].capitalize}box"
  end
