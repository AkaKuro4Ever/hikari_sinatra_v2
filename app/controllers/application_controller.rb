require './config/environment'
class ApplicationController < Sinatra::Base

configure do
  set :views, Proc.new { File.join(root, "../views") }
  enable :sessions
  set :session_secret, "password_security"
end

  get '/' do

    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
