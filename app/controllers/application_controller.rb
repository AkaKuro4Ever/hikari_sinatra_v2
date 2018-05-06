require './config/environment'
class ApplicationController < Sinatra::Base

configure do
  set :views, Proc.new { File.join(root, "../views/") }
end

  get '/' do

    erb :index
  end
end
