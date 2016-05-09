class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient_id: current_user.id).reverse_order.includes({ comment: [:blog] }).limit(5)
    @notifications.update_all(read: true)
  end

  def more
    count = params[:count]
    limit_num = count.to_i * 5 + 5

    @notifications_all_count = Notification.where(recipient_id: current_user.id).reverse_order.includes({ comment: [:blog] }).count
    @notifications = Notification.where(recipient_id: current_user.id).reverse_order.includes({ comment: [:blog] }).limit(limit_num)
    @notifications.update_all(read: true)

    respond_to do |format|
      format.js
    end
  end

  def list
    @notifications_replace = Notification.where(recipient_id: current_user.id).reverse_order.includes({ comment: [:blog] })
    @notifications_count_replace =  Notification.where(recipient_id: current_user.id).unread.count

    respond_to do |format|
      format.js
    end
  end
end
