class CommentsController < ApplicationController

  before_action :set_task_and_project
  before_action :authenticate


  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:user_id, :task_id, :remark))
    @comment.user_id = current_user.id
    @comment.task_id = @task.id
    redirect_to project_task_path(@project, @task)
  end

  def set_task_and_project
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
  end
end
