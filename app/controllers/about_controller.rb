class AboutController < ApplicationController
  def index
    @projects_num = Project.all.count
    @tasks_num = Task.all.count
    @memberships_num = Membership.all.count
    @users_num = User.all.count
    @comments_num = Comment.all.count
  end
end
