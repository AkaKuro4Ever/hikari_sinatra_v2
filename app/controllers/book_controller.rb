class BookController < ApplicationController
require 'pry'
configure do
  # set :views, Proc.new { File.join(root, "../views/") }
end


  get '/books/books' do
    @books = Book.all
    erb :'/book/index'
  end

  #CREATE

  get '/books/new' do
    @authors = Author.all
    @genres = Genre.all
    erb :'/book/new'
  end

  post '/books' do
    @authors = Author.all
    @genres = Genre.all
    # if params[:book][:title].empty?
    #   @message = "Please add a title to your new book addition."
    #   erb :'/book/new'
    # elsif params[:book][:author].empty? && params[:book][:author_id].empty?
    #   @message = "Please add an author to your new book addition."
    #   erb :'/book/new'
    # elsif params[:book][:genre].empty? && params[:book][:genre_id].empty?
    #   @message = "Please add a genre to your new book addition."
    #   erb :'/book/new'
    # elsif !params[:bookA][:author].empty? && params[:book][:author_id] != nil
    #   @message = "Please fill in only one author."
    #   erb :'/book/new'
    # elsif !params[:book][:genre].empty? && !params[:book][:genre_id] != nil
    #   @message = "Please fill in only one genre."
    #   erb :'/book/new'
    # else
      title = params[:book][:title].strip.split.map(&:capitalize).join(' ')
      author = params[:book][:author].strip.split.map(&:capitalize).join(' ')
      genre = params[:book][:genre].strip.split.map(&:capitalize).join(' ')
    # end
    @book = Book.new(title: title)
    if !params[:book][:author].empty?
      if @author = Author.all.find_by(name: params[:book][:author])
        @author.books << @book
      else
		    @author = Author.create(name: author)
        @author.books << @book
      end
    else
      @author = Author.all.find_by(id: params[:book][:author_id])
      @author.books << @book
		end
    if !params[:book][:genre].empty?
      if @genre = Genre.all.find_by(name: params[:book][:genre])
        @genre.books << @book
      else
		    @genre = Genre.create(name: genre)
        @genre.books << @book
      end
    else
      @genre = Genre.all.find_by(id: params[:book][:genre_id])
      @genre.books << @book
		end
    @book.save
    redirect "/books/#{@book.id}"
  end

  #READ

  get '/books/:id' do

    @book = Book.find_by(id: params[:id])
    erb :'/book/show'
  end

  #UPDATE

  get '/books/:id/add' do
    @book = Book.find_by(id: params[:id])
    if logged_in?
      if current_user.books.include?(@book)
        @message = "You've already checked this book out!"
        erb :'/book/show'
      else
        current_user.books << @book
        @user = current_user
        erb :'/users/show'
      end
    else
      @message = "Please log in to check this book out."
      erb :'/book/show'
    end
  end

  get '/books/:id/delete' do

    @book = Book.find_by(id: params[:id])
    if logged_in?
      current_user.books.delete(@book)
      redirect to "users/#{current_user.id}"
    else
      @message = "Please log in to return this book."
      erb :'/book/show'
    end
  end

  get '/books/:id/edit' do

    @book = Book.find_by(id: params[:id])
    if @book.user != current_user
      @message = "You are not authorized to edit this book. Please log in to the correct account."

      redirect "/books/#{@book.id}"
    else
      if !logged_in?
        @message = "Sorry, to edit book information, you must be logged in. Please log in now."

        erb :'/book/show'
      else
        erb :'/book/edit'
      end
    end
  end

  patch '/books/:id' do

    @book = Book.find_by(id: params[:id])
    if @book.user != current_user
      @message = "You are not authorized to edit this book. Please log in to the correct account."

      erb :'/book/edit'
    else
      author = params[:book][:author].strip.split.map(&:capitalize).join(' ')
      genre = params[:book][:genre].strip.split.map(&:capitalize).join(' ')
      #Updates title if title box is filled out
      if params[:book][:title] != ""
        @book.title = params[:book][:title].split.map(&:capitalize).join(' ')
      end
      #If both are authors filled, redirects
      if author != "" && params[:book][:author_id] != nil
        redirect :"/books/#{@book.id}/edit"
      #If top is filled out, but author exists, it assigns existing author
      elsif author != "" && Author.check(author)
        @book.author = Author.find_by(name: author)
      #If top is filled out and author doesn't exist, it assigns top
      elsif author != ""
        @book.author = Author.create(name: author)
      else
        nil
      #If top isn't filled out, it assigns bottom
      end

      if params[:book][:author_id] != nil
        @book.author = Author.find_by(id: params[:book][:author_id])
      end
      #GENRE --------
      #If both are genres filled, redirects
      if params[:book][:genre_id] != nil && genre != ""
          redirect :"/books/#{@book.id}/edit"
      end
      #If top is filled out, but genre exists, it assigns existing genre
      if genre != "" && Genre.check(genre)
        @genre = Genre.all.find_by(name: genre)
        @genre.books << @book
      #If top is filled out and genre doesn't exist, it assigns top
      elsif genre != ""
        @genre = Genre.create(name: genre)
        @genre.books << @book
      #No matter what, it assigns bottom
      else
      end
      if params[:book][:genre_id] != nil
        @genre = Genre.all.find_by(id: params[:book][:genre_id])
        @genre.books << @book
      end

      @book.save
      erb :'/book/show'
    end
  end

  #DELETE
  delete '/books/:id/delete' do

    if logged_in?
      @book = Book.find_by(id: params[:id])
      @book.destroy
      redirect '/books/books'
    else
      @message = "Please log in to be able to delete this manga."
      erb :'/book/show'
    end
  end
end
