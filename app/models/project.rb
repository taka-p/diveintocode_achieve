class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  has_many :members
  has_many :tasks, dependent: :destroy

  # projectのメンバーか判定
  def members?
    member = Member.find_by(user_id: self.user.id)
    ! member.nil?
  end

  # projectの作成者か判定
  def manager?(user)
    project = Project.find(self.id)
    project.user == user
  end
end
