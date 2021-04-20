class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :sender_id
      t.string :message
      t.string :url
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
