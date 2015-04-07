class Comment < ActiveRecord::Base

  validates :remark, presence: true
  belongs_to :user
  belongs_to :task

end
