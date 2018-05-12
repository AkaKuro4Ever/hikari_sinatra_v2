class BookController < ApplicationController
require 'pry'
configure do
  set :views, Proc.new { File.join(root, "../views/") }
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
    binding.pry
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
        erb :'/books/show'
      else
        current_user.books << @book
        @user = current_user
        erb :'/users/show'
      end
    else
      @message = "Please log in to check this book out."
      erb :'/books/show'
    end
  end

  patch '/books/:id/delete' do

    @book = Book.find_by(id: params[:id])
    if logged_in?
      current_user.books.delete(@book)
      redirect to "users/#{current_user.id}"
    else
      @message = "Please log in to return this book."
      erb :'/books/show'
    end
  end

  get '/books/:id/edit' do

    @book = Book.find_by(id: params[:id])
    erb :'/book/edit'
  end

  patch '/books/:id' do

    @book = Book.find_by(id: params[:id])
    if params[:title] != nil
      Book.update(title: params[:title])
    end
    if author = Author.find_by(name: params[:author])
      Book.update(author: author)
    else
      Book.update(author: Author.create(name: params[:author]))
    end

    if genre = Genre.find_by(name: params[:genre])
      Book.update(genre: genre)
    else
      Book.update(genre: Genre.create(name: params[:genre]))
    end

    erb :'/book/show'
  end

  #DELETE
  delete '/books/:id' do

    @book = Book.find_by(id: params[:id])
    redirect '/book/index'
  end
end
