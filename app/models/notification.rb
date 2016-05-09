class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: 'Conversation', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'Conversation', foreign_key: :recipient_id
  belongs_to :comment, class_name: 'Comment', foreign_key: :comment_id
  belongs_to :submit_request

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
  scope :unread_count, -> (user_id) { where(recipient_id: user_id).unread.count }

  def sender_user
    User.find(self.sender_id)
  end

  def receive_user
    User.find(self.recipient_id)
  end

  def posted_time
    self.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def display_read_status
    if self.read
      return '既読'
    else
      return '未読'
    end
  end

  def self.sending_pusher(channel_user_id)
    Pusher.trigger("notifications#{channel_user_id}", 'message', {
        unread_count: Notification.unread_count(channel_user_id)
    })
  end
end
