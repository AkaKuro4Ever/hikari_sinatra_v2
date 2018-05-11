class BookController < Sinatra::Base
require 'pry'
configure do
  set :views, Proc.new { File.join(root, "../views/") }
end

  #CREATE

  get '/books/new' do
    @authors = Author.all
    @genres = Genre.all
    erb :'/book/new'
  end

  post '/books' do
    binding.pry
    if params[:book][:title].empty?
      @message = "Please add a title to your new book addition."
      erb :'/book/new'
    elsif params[:book][:author].empty? && params[:book][:author_id].empty?
      @message = "Please add an author to your new book addition."
      erb :'/book/new'
    elsif params[:book][:genre].empty? && params[:book][:genre_id].empty?
      @message = "Please add a genre to your new book addition."
      erb :'/book/new'
    else
      title = params[:book][:title].strip.split.map(&:capitalize).join('')
      author = params[:book][:author].strip.split.map(&:capitalize).join('')
      genre = params[:book][:genre].strip.split.map(&:capitalize).join('')
    end
    @book = Book.new(title: title)
    if !params[:book][:author].empty?
		  @author = Author.create(name: author)
      @author.books << @book
    else
      @author = Author.all.find_by(id: params[:book][:author_id])
      @author.books << @book
		end
    if !params[:book][:genre].empty?
		  @genre = Genre.create(name: genre)
      @genre.books << @book
    else
      @genre = Genre.all.find_by(id: params[:book][:genre_id])
      @genre.books << @book
		end
    @book.save
    erb :'book/show'
  end

  #READ
  get '/books' do

    @books = Book.all
    erb :'/book/index'
  end

  get '/books/:id' do

    @book = Book.find_by(id: params[:id])
    erb :'/book/show'
  end

  #UPDATE
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
