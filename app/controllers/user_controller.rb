class UserController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions_secret, "secret"
    set :views, Proc.new { File.join(root, "../views/") }
  end

  #The configure block above is a part of built-in settings that control whether features are enabled or not. In this case, we're enabling the sessions feature.

  get '/login' do

    erb :'/users/login'
  end

  get '/signup' do

    erb :'/users/signup'
  end

  post '/signup' do

    # if @user.authenticate etc.
    # binding.pry
    # { |value| value.empty? }
    if params.values.any?(&:empty?)
      @message = "All fields must be filled in to create a user account"
      erb :'users/signup'
    else
      @user = User.new(email: params[:email], username: params[:username], password: params[:password])
      @user.save
    redirect "/users/#{@user.id}"
    end
  end

  post '/login' do

    @user = User.find_by(email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    erb :'/users/show'
  end

  get '/users/logout' do
    session.clear

    redirect "/"
  end

  get '/users/:id' do

    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/:username' do
    @session = session
    #Because we enabled sessions in our app, every controller action has access to the session hash.
  end
end
