class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient_id: current_user.id).reverse_order.includes({ comment: [:blog] })
    @notifications.update_all(read: true)
  end

  def list
    @notifications_replace = Notification.where(recipient_id: current_user.id).reverse_order.includes({ comment: [:blog] })
    @notifications_count_replace =  Notification.where(recipient_id: current_user.id).unread.count

    respond_to do |format|
      format.js
    end
  end
end
