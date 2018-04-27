require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
  end

  get '/' do
    erb :index
  end

  get '/info' do
    erb :info
  end

  get '/book/new' do
    erb :new
  end
end
