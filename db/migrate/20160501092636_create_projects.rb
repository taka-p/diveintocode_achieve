class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :content
      t.references :user, index: true, null: false
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :projects, :users
    add_foreign_key :projects, :customers
  end
end
