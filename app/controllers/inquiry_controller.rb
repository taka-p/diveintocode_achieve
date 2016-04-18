class InquiryController < ApplicationController
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
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.send_email(@inquiry).deliver

    render :action => 'thanks'
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message)
    end
end
