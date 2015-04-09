class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  validate :must_have_an_owner
  validates :user_id, presence: true, uniqueness: {scope: :project_id, message: "was already added to this project."}

  enum role: {member: 0, owner: 1}

  def must_have_an_owner
    project = Project.find(project_id)
    owners = []
    project.memberships.each do |membership|
      if membership.role == "owner"
        owners << membership
      end
    end
    if owners.empty?
      errors.add(:project, "must have at least one owner")
    end
  end

end
