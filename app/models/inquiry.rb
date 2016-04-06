class Inquiry < ActiveRecord::Base
  validates :name, :presence => {:message => '名前を入力して下さい'}
  validates :email, :presence => {:message => 'メールアドレスを入力して下さい'}
end
