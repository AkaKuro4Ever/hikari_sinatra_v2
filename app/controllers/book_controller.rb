class BookController < Sinatra::Base

configure do
  set :views, Proc.new { File.join(root, "../views/") }
end

  get '/book/new' do
    erb :new
  end

  post '/book' do

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
    erb :'book/book'
  end
end
