# == Schema Information
#
# Table name: inquiries
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Inquiry < ActiveRecord::Base
  VALID_EMAIL_REGEXP = /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/

  validates :name, presence: { message: '名前を入力して下さい' }
  validates :email,
   presence: { message: 'メールアドレスを入力して下さい' },
   format: { with: VALID_EMAIL_REGEXP, message: 'メールアドレスが不正です' }
  validates :message,  presence: { message: 'お問い合わせ内容を入力して下さい' }
end
