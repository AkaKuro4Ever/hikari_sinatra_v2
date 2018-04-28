class UserController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions_secret, "secret"
  end

  #The configure block above is a part of built-in settings that control whether features are enabled or not. In this case, we're enabling the sessions feature.

  get '/login' do

  end

  post '/login' do

  end

  get '/:username' do
    @session = session
    #Because we enabled sessions in our app, every controller action has access to the session hash.
  end
end
