class AddColumnToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :submit_request, index: true
    add_foreign_key :notifications, :submit_requests
  end
end
