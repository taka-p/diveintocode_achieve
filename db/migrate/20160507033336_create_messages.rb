class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.references :user, index: true
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :messages, :conversations
    add_foreign_key :messages, :users
  end
end
