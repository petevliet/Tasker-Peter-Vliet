class MembershipsController < ApplicationController
  before_action :set_project

  def index
    @membership = Membership.new
    @memberships = @project.memberships.all
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id

    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.fullname} was successfully added"
    else
      flash.now[:alert] = @membership.errors.full_messages
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.first_name} was successfully updated"
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: 'Membership was successfully destroyed.'
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
