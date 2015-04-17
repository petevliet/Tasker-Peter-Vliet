class ProjectsController < ApplicationController
  layout 'current_user_layout'

  before_action :authenticate
  before_action :member_of?, except: [:index, :new, :create]
  before_action :owner_of?, only: [:edit, :update, :destroy]

  def index
      @adminprojects = Project.all
      @memberships = Membership.where(user_id: current_user.id)
  end

  def show
    @project = Project.find(params[:id])
    if current_user.admin || @project.memberships.where(user_id: current_user.id)[0].role == "owner"
      @owner = current_user
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      # user is made project owner upon project creation
      @membership = Membership.new
        @membership.user_id = current_user.id
        @membership.project_id = @project.id
        @membership.role = 1
        @membership.save
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end

  end

  def update
    @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @project = Project.find(params[:id])

    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end

end
