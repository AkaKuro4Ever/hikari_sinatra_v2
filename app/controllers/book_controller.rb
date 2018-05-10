class BookController < Sinatra::Base
require 'pry'
configure do
  set :views, Proc.new { File.join(root, "../views/") }
end

  #CREATE

  get '/books/new' do
    @authors = Author.all
    erb :'/book/new'
  end

  post '/books' do
    binding.pry
    author = params[:book][:author].strip.split.map(&:capitalize).join('')
    genre = params[:book][:genre].strip.split.map(&:capitalize).join('')
    @book = Book.new(title: params[:book][:title])
    if !Author.all.find_by(name: author)
      @author = Author.new(name: author)
      @author.books << @book
      @author.save
    # else
    #
    #   @author.books << @book
    end
    if !Genre.all.include?(name: params[:genre])
      @genre = Genre.new(name: params[:genre])
      @genre.books << @book
      @genre.save
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
