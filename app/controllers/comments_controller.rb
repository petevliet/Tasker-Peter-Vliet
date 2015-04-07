class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:user_id, :task_id, :body))
    if @comment.save
      redirect_to project_task_path(@project, @task)
    end
  end

end
