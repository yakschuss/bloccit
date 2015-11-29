class AddRatingToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :rating, index: true
    add_foreign_key :posts, :ratings
  end
end
