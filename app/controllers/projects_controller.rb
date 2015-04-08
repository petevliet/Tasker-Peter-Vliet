class ProjectsController < ApplicationController

  before_action :authenticate
  before_action :member_of?, except: [:index, :new, :create]

  def index
    @memberships = Membership.where(user_id: current_user.id)
    # @projects = Project.where(id: memberships.project_id)
  end

  def show
    @project = Project.find(params[:id])
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

    def membership_params
      params.require(:membership).permit(:user_id, :project_id, :role)
    end

end
