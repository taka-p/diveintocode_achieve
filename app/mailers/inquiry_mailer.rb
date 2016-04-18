class InquiryMailer < ActionMailer::Base
  require 'net/pop'

  add_template_helper(ApplicationHelper)

  def send_email(inquiry)
    @inquiry = inquiry
    mail(
        from: 'Archive',
        to: @inquiry.email,
        subject: 'お問い合わせありがとうございます'
    )
  end

  @address = 'POP3saver' # <= 自分のPOP3サーバー
  @port = 110 # <= ポート番号 110など
  @id = 'userid' # <= ユーザーＩＤ
  @pass = 'password' # <= パスワード

  def receive(email)
    page = Page.find_by_address(email.from.first) ||
        Page.create(:address => email.from.first)
    str = email.subject.kconv(Kconv::UTF8, Kconv::JIS) # JIS から UTF8 に変換
    page.emails.create(
        :subject => str,
        :body => email.body,
        :header => email.header,
        :messageid => email.message_id,
        :receivedate => email.date
    )

    if email.has_attachments?
      for attachment in email.attachments
        str = attachment.original_filename.kconv(Kconv::UTF8, Kconv::JIS)
        page.attachments.create({
                                    :file => attachment,
                                    :description => email.subject,
                                    :filename => str
                                })
      end
    end
  end

  def Mailreceiver.r_m
    pop = Net::POP3.new(@address, @port)
    pop.start(@id, @pass)
    if !pop.mails.empty? then
      pop.each_mail do |m|
        receive(m.pop) # 受信したメールを、「処理」する（DBへ登録）
        m.delete # 受信したメールをサーバから削除
      end
    end
    pop.finish
  end
end
