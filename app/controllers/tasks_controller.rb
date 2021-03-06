class TasksController < ApplicationController
  layout 'current_user_layout'

  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  before_action :authenticate
  before_action :task_member_of?


  def index
    @tasks = @project.tasks.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id

    if @task.save
      redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
      redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def task_params
      params.require(:task).permit(:description, :due_date, :complete, :project_id)
    end
end
