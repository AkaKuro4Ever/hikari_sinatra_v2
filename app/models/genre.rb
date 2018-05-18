class Genre < ActiveRecord::Base

  has_many :books
  has_many :authors, through: :books

  def self.check(params)
    self.all.find {|genre| genre.name == params}
  end
end
