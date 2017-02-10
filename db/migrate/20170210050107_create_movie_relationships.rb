class CreateMovieRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_relationships do |t|
      t.integer :movie_id1, null: false
      t.integer :movie_id2, null: false
      t.timestamps
    end
    add_index :movie_relationships, [:movie_id2, :movie_id1]
  end
end
