class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.string :title
      t.text :content
      t.datetime :deadline
      t.integer :charge_id
      t.boolean :done
      t.integer :status

      t.timestamps null: false
    end
    add_foreign_key :tasks, :users
  end
end
