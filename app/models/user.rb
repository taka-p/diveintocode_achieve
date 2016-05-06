class User < ActiveRecord::Base
  # blog
  has_many :blogs, dependent: :destroy
  # blog > comment
  has_many :comments, dependent: :destroy

  # follow - 中間テーブルrelationshipsとの関係を定義
  has_many :relationships,
           foreign_key: "follower_id", dependent: :destroy
  has_many :reverce_relationships,
           foreign_key: "followed_id", class_name: 'Relationship', dependent: :destroy

  # follow - 相対的な参照関係を定義
  has_many :followed_users,
           through: :relationships, source: :followed
  has_many :followers,
           through: :reverce_relationships, source: :follower

  # task
  has_many :tasks, dependent: :destroy

  # project member
  has_many :projects, dependent: :destroy
  has_many :members, dependent: :destroy

  # submit_request
  has_many :submit_requests, dependent: :destroy

  # フォロー登録
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # フォロー解除
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  # フォロー確認
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  # 「自分が」フォローし合っているユーザの取得
  def friend
    User.from_users_followed_by(self)
  end

  # フォローし合っているユーザの取得
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT X.id FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = :user_id) X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = :user_id) Y ON X.id = Y.id"
    where("id IN (#{followed_user_ids})", user_id: user.id)
  end

  # フォローし合っているユーザのタスクフィードを取得
  def taskfeed
    tasks = Task.where(user_id: self)
    Task.from_users_followed_by(self).order("updated_at DESC")
  end

  # kaminari用
  paginates_per 20

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
