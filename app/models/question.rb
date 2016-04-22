class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :language
  has_many :answers, dependent: :destroy

  validates :language_id, presence: { message: '言語を選択してください' }
  validates :category_id, presence: { message: 'カテゴリーを選択してください' }
end
