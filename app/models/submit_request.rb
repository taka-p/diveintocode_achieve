class SubmitRequest < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :charger, class_name: 'User', foreign_key: 'charge_id'
  has_many :notifications, dependent: :destroy

  # 依頼作成時にお知らせも作成する
  accepts_nested_attributes_for :notifications

  delegate :name, to: :user, prefix: true
end
