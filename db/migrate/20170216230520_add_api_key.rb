class AddApiKey < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :session, :string, unique: true, index: true
  end
end
