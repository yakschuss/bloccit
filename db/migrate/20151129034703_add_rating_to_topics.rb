class AddRatingToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :rating, index: true
    add_foreign_key :topics, :ratings
  end
end
