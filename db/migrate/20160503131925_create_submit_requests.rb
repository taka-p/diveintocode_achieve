class CreateSubmitRequests < ActiveRecord::Migration
  def change
    create_table :submit_requests do |t|
      t.references :task, index: true
      t.references :user, index: true
      t.integer :charge_id, null: false
      t.integer :status
      t.text :message

      t.timestamps null: false
    end
    add_foreign_key :submit_requests, :tasks
    add_foreign_key :submit_requests, :users
  end
end
