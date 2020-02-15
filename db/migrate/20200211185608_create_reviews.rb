class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :dish_id
      t.integer :customer_id
      t.integer :rating
    end 
  end
end
