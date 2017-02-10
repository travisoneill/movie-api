class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :description
      t.integer :year
      t.timestamps
    end
    add_index :movies, [:title], unique: true
    add_index :movies, [:year]
  end
end
