class MembershipsController < ApplicationController
  layout 'current_user_layout'

  before_action :set_project
  before_action :task_member_of?
  before_action :last_owner?, only: [:index, :update]

  def index
    @membership = Membership.new
    @memberships = @project.memberships.all
    @project = Project.find(params[:project_id])
    # owner is defined if current user is project owner
    if current_user == @project.memberships.find_by(role: 1).user
      @owner = current_user
    end
    # project must have at least one owner
    if @owners_count == 1
      @last_owner = @memberships.where(role: 1)
    end
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
    if @owners_count == 1 && @membership.role == "owner"
      redirect_to project_memberships_path(@project), alert: "Project must have at least one owner"
    elsif @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.first_name}\'s membership was successfully updated"
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    # different redirect paths if destroyer is current user or admin
    if @membership.user == current_user
      redirect_to projects_path(@membership.user), notice: "#{@membership.user.fullname} was successfully removed."
    else
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.fullname} was successfully removed."
    end
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  # projects must have at least one owner, this is owners count calculated here.
  def last_owner?
    @project = Project.find(params[:project_id])
    @owners_count = @project.memberships.where(role: 1).count
  end

end
