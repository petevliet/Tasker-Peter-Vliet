class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new
    @memberships = @project.memberships.all
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id

    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.fullname} was successfully added"
    else
      render :index
    end
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
