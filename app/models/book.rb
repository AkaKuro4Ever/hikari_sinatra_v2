class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :genre
  belongs_to :user
  has_many :user_books
  has_many :user, through: :user_books
end
