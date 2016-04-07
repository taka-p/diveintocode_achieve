class ChangeUserNameOptionsToUsers < ActiveRecord::Migration
  def up
    change_column :users, :username, :string
  end

  def down
    change_column :users, :username, :string
  end
end
