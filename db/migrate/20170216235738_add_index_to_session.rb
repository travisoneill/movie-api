class AddIndexToSession < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :session, unique: true
  end
end
