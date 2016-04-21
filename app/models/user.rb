# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  profile                :text
#  uid                    :string           default(""), not null
#  provider               :string           default(""), not null
#  provider_name          :string
#  image_url              :string
#  image                  :string
#

class User < ActiveRecord::Base
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy

  # currierwave用
  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  def update_with_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params, *options)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      # 認証時、emailの提供を拒否された場合はランダムなemailを作成
      auth.info.email = User.create_unique_email if auth.info.email.nil?

      user = User.create(name: auth.extra.raw_info.name,
                         provider_name: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: Devise.friendly_token[0, 20])

    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(name: auth.info.nickname,
                         provider_name: auth.info.nickname,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: User.create_unique_email,
                         password: Devise.friendly_token[0, 20])
    end
    user
  end

  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  private
    # currierwave用
    def user_params
      params.require(:user).permit(:name, :description, :image)
    end
end
