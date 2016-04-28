class CreateGoodjobs < ActiveRecord::Migration
  def change
    create_table :goodjobs do |t|
      t.references :user, index: true
      t.references :task, index: true
      t.string :number
      t.string :integer

      t.timestamps null: false
    end
    add_foreign_key :goodjobs, :users
    add_foreign_key :goodjobs, :tasks
  end
end
