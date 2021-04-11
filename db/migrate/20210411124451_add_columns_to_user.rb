class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string, limit: 15
    add_column :users, :lastname, :string, limit: 15
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
  end
end
