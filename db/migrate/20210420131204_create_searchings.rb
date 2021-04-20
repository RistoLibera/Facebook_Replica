class CreateSearchings < ActiveRecord::Migration[6.1]
  def change
    create_table :searchings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :word

      t.timestamps
    end
  end
end
