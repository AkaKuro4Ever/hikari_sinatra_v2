class UserController < ApplicationController

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
  end

  #The configure block above is a part of built-in settings that control whether features are enabled or not. In this case, we're enabling the sessions feature.

  get '/login' do

    erb :'/users/login'
  end

  #CREATE
  get '/signup' do

    erb :'/users/signup'
  end

  post '/signup' do

    if params.values.any?(&:empty?)
      #or { |value| value.empty? }
      @message = "All fields must be filled in to create a user account" #CHANGE TO FLASH LATER
      erb :'users/signup'
    else
    @user = User.new(email: params[:email], username: params[:username].capitalize, password: params[:password])
    # Because our user has has_secure_password, we won't be able to save this to the database unless our user filled out the password field. Calling user.save will return false if the user can't be persisted.
    #MUST DO VALIDATION FOR UNIQUE PASSWORDS, EMAILS, USERNAMES
      if @user.save
        session[:user_id] = @user.id
        redirect to "users/#{@user.id}"
      else
        @message = "All fields must be filled in to create a user account" #CHANGE TO FLASH LATER
        erb :'users/signup'
      end
    end
  end

  post '/login' do

    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      @message = "Sorry, we couldn't find this account. Please try again." #CHANGE TO FLASH MESSAGE LATER
      erb :'/users/login'
    end
  end

  get '/logout' do
    session.clear

    redirect "/"
  end

  #READ
  get '/users/:id' do

    @user = User.find_by(id: params[:id])

    erb :'/users/show'
  end

  #UPDATE
  get '/users/:id/edit' do

    @user = User.find_by(id: params[:id])

    erb :'/users/edit'
  end

  patch '/users/:id' do

    @user = User.find_by(id: params[:id])
    binding.pry
    params[:book_ids].each do |id|
      if  book = @user.books.find_by(id: id)
        @user.books.delete(book)
      end
    end

    redirect "/users/#{@user.id}"
    # @user.books.where(category: ['Something', 'Else']).delete_all
    # @user.books.where(id: params[:book_ids]).destroy_all
  end

  get '/:username' do
    @session = session
    #Because we enabled sessions in our app, every controller action has access to the session hash.
  end

  #DELETE
end
