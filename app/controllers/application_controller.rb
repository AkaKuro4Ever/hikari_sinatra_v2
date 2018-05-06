require './config/environment'
class ApplicationController < Sinatra::Base

configure do
  set :views, Proc.new { File.join(root, "../views/") }
end

  get '/' do

    DO SOMETHING GOD
  end
end
