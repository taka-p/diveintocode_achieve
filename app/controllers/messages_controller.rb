class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last && (@messages.last.user_id != current_user.id)
      @messages.last.read = true
    end

    @message = @conversation.messages.build(user_id: current_user.id)
  end

  def new
    @message = @conversation.messages.build(user_id: current_user.id)
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      Pusher['notifications' + @message.conversation.recipient_id.to_s]
          .trigger('message', { messaging: "メッセージが届いています。 :#{@message.body}" })
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
