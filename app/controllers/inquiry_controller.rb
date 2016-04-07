class InquiryController < ApplicationController
  # ログイン判定
  # before_action :authenticate_user!

  def index
    if params['back']
     @inquiry = Inquiry.new(inquiry_params)
    else
      @inquiry = Inquiry.new
    end
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def thanks
    @inquiry = Inquiry.create(inquiry_params)
    # DAY3ではメーラーの実装無し
    render :action => 'thanks'
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message)
    end
end
