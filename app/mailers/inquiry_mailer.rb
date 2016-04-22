class InquiryMailer < ActionMailer::Base
  require 'net/pop'
  require 'mail'
  require 'kconv'

  add_template_helper(ApplicationHelper)

  # お問い合わせメール（管理者に送る）
  def send_email(inquiry)
    @inquiry = inquiry
    mail(
        from: @inquiry.email,
        to: ENV['RAILS_ACHIEVE_MAILER_USER_ID'],
        subject: 'Achieve'
    )
  end

  # 確認メール（お問い合わせした人に送る）
  def send_check_email(inquiry)
    @inquiry = inquiry
    mail(
        from: 'Archive',
        to: @inquiry.email,
        subject: 'お問い合わせありがとうございます'
    )
  end

  # answerが投稿されたら質問者にメールを送る
  def send_notice_answer_email(inquiry)
    @inquiry = inquiry
    mail(
        from: 'Archive',
        to: @inquiry.email,
        subject: '質問に回答がありました'
    )
  end

  def receive(email)
    page = Page.find_by_address(email.from.first) ||
        Page.create(:address => email.from.first)

    tmp = email.body
    if tmp.multipart?
      logger.debug "マルチパートだよ"
      # 恐らくエンコードが必要
      # .kconv(Kconv::UTF8, Kconv::JIS) JIS から UTF8 に変換
      tmp = email.parts[0].body.to_s
    end

    page.emails.create(
        :subject => email.subject,
        :body => tmp,
        :header => email.header,
        :messageid => email.message_id,
        :receivedate => email.date
    )

    # 添付ファイルは保存しない
    # if email.has_attachments?
    #   for attachment in email.attachments
    #     str = attachment.filename
    #     page.attachments.create({
    #                                 :file => attachment,
    #                                 :description => email.subject,
    #                                 :filename => str
    #                             })
    #   end
    # end
  end

  # メールを受信するトリガーメソッド
  def receive_trigger
    @address = 'pop.gmail.com'
    @port = 995
    @id = ENV['RAILS_ACHIEVE_MAILER_USER_ID']
    @pass = ENV['RAILS_ACHIEVE_MAILER_PASSWORD']

    logger.debug "POP接続開始"
    Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
    pop = Net::POP3.new(@address, @port)
    pop.start(@id, @pass)
    unless pop.mails.empty?
      pop.each_mail do |m|
        InquiryMailer.receive(m.pop) # 受信したメールを、「処理」する（DBへ登録）
        m.delete # 受信したメールをサーバから削除
      end
    end
    pop.finish
    logger.debug "POP接続完了"
  end
end
