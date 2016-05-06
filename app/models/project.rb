class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  has_many :members, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # projectのメンバーか判定
  def members?(user)
    members = Member.where(project_id: self.id).where(user_id: user.id)
    ! members[0].nil?
  end

  # projectの作成者か判定
  def manager?(user)
    project = Project.find(self.id)
    project.user == user
  end

  # projectのメンバーか判定
  def project_members?(user)
    project_members = self.members.find_by(user_id: user.id)
    ! project_members.nil?
  end
end
