class User < ActiveRecord::Base
  has_secure_password
  has_many :books
  has_many :user_books
  has_many :books, through: :user_books

end
