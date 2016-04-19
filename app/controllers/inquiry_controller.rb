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
    InquiryMailer.send_check_email(@inquiry).deliver

    render :action => 'thanks'
  end

  # 受信箱一覧
  def list
    if params[:received].blank?
      InquiryMailer.receive_trigger.deliver
    end
    @emails = Email.where(subject: 'Achieve').reverse_order
  end

  # 受信箱詳細
  def show
    @email = Email.find(params[:id])
  end

  # メールを受信するjobを走らせる
  def receive_email
    InquiryMailer.receive_trigger.deliver
    # job = open('|ruby script/runner Mailreceiver.r_m')
    redirect_to inquiry_list_path(received:true), notice: '最新の状態に更新しました'
  end

  private

    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message)
    end
end
