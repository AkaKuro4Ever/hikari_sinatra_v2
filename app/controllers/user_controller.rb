class UserController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions_secret, "secret"
    set :views, Proc.new { File.join(root, "../views/") }
  end

  #The configure block above is a part of built-in settings that control whether features are enabled or not. In this case, we're enabling the sessions feature.

  get '/' do

    erb :index
  end

  get '/login' do

    erb :'/users/login'
  end

  get '/signup' do

    erb :'/users/signup'
  end

  post '/signup' do
    if true
      erb :'/users/signup'
    end
    # if @user.authenticate etc.
    binding.pry
    @user = User.new(email: params[:email], username: params[:username], password: params[:password])
    @user.save
    @user = User.find_by(email: params[:email])

    redirect '/users/show'
  end

  post '/login' do

    erb :'/users/show'
  end

  get '/:username' do
    @session = session
    #Because we enabled sessions in our app, every controller action has access to the session hash.
  end
end
