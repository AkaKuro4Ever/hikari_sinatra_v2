class Createbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :author_id
    end
  end
end

books - belongs_to :author, :genre
artists - has_many :books, :genres, through: :books
genre - has_many :books, :authors, through: :books
