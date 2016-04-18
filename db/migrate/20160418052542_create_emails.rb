class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.column :page_id, :integer
      t.column :subject, :string
      t.column :receivedate, :timestamp
      t.column :messageid, :string
      t.column :header, :text
      t.column :body, :text

      t.timestamps null: false
    end
  end
end
