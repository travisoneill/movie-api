class CreateMovieRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_ratings do |t|
      t.integer :user_id, null: false, index: true
      t.integer :movie_id, null: false, index: true
      t.integer :rating, null: false
      t.timestamps
    end
  end
end
