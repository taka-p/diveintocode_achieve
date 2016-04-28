class CreateTaskComments < ActiveRecord::Migration
  def change
    create_table :task_comments do |t|
      t.references :user, index: true
      t.references :task, index: true
      t.string :content

      t.timestamps null: false
    end
    add_foreign_key :task_comments, :users
    add_foreign_key :task_comments, :tasks
  end
end
