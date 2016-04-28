class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, null: false
      t.string :title
      t.text :content
      t.datetime :deadline
      t.integer :charge_id, null: false
      t.boolean :done, default: false
      t.integer :status, default: 0

      t.timestamps null: false
    end
    add_foreign_key :tasks, :users
  end
end
