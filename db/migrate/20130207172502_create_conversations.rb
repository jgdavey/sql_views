class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :to_id, null: false
      t.integer :from_id, null: false
      t.string :subject, null: false
      t.timestamps
    end

    add_index :conversations, :to_id
    add_index :conversations, :from_id
  end
end
