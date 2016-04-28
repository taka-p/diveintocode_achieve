class Taskline::TaskComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
end
