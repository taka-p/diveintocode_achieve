class Relationship < ActiveRecord::Base
  # フォロー・フォロワーの識別を定義
  # relationshipsテーブルのfollower_idを参照
  belongs_to :follower, class_name: 'User'
  # relationshipsテーブルのfollowed_idを参照
  belongs_to :followed, class_name: 'User'
end
