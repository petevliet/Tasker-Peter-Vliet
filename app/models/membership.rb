class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  validates :user_id, presence: true, uniqueness: {scope: :project_id, message: "was already added to this project."}

  enum role: {member: 0, owner: 1}

end
