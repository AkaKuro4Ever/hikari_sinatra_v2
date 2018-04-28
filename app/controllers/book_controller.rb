class BookController < Sinatra::Base

configure do
  set :views, Proc.new { File.join(root, "../views/") }
end

  get '/books/new' do
    erb :'/book/new'
  end

  post '/books' do

    @book = Book.new(title: params[:title])
    if !Author.all.include?(name: params[:author])
      @author = Author.new(name: params[:author])
      @author.books << @book
    end
    if !Genre.all.include?(name: params[:genre])
      @genre = Genre.new(name: params[:genre])
      @genre.books << @book
    end
    @author.save
    @genre.save
    @book.save
    erb :'book/show'
  end

  get '/books' do

    erb :'/book/index'
  end

  get '/books/:id' do

    erb :'/book/show'
  end

  get '/books/:id/edit' do

    erb :'/book/edit'
  end

  put '/books/:id' do

    erb :'/book/show'
  end

  delete '/books/:id' do

    redirect '/book/index'
  end
end
