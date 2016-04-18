class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.column :page_id, :integer
      t.column :file, :binary
      t.column :filename, :string
      t.column :description, :string

      t.timestamps null: false
    end
  end
end
