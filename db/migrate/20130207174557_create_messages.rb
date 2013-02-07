class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :conversation, null: false
      t.belongs_to :user, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :messages, :conversation_id
  end
end
