class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient_id: current_user.id)
                         .reverse_order.includes({ comment: [:blog] })
    @notifications.update_all(read: true)
  end
end
