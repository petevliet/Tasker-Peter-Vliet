namespace :clean do

  task memberships_users: :environment do
    Membership.all.each do |membership|
      if membership.user.nil?
        membership.destroy
      end
    end
  end

  task memberships_projects: :environment do
    Membership.all.each do |membership|
      if membership.project.nil?
        membership.destroy
      end
    end
  end

  task tasks_projects: :environment do
    Task.all.each do |task|
      if task.project.nil?
        task.destroy
      end
    end
  end

  task comments_tasks: :environment do
    Comment.all.each do |comment|
      if comment.task.nil?
        comment.destroy
      end
    end
  end

  task user_id_comments: :environment do
    Comment.all.each do |comment|
      if comment.user.nil?
        comment.user_id = nil
        comment.save
      end
    end
  end

  task task_remove: :environment do
    Task.all.each do |task|
      if task.project.nil?
        task.destroy
      end
    end
  end

  task comment_remove: :environment do
    Comment.all.each do |comment|
      if comment.task.nil?
        comment.destroy
      end
    end
  end

  task membership_remove: :environment do
    Membership.all.each do |membership|
      if membership.project.nil? || membership.user.nil?
        membership.destroy
      end
    end
  end

end



# Removes all memberships where their users have already been deleted
# Removes all memberships where their projects have already been deleted
# Removes all tasks where their projects have been deleted
# Removes all comments where their tasks have been deleted
# Sets the user_id of comments to nil if their users have been deleted
# Removes any tasks with null project_id
# Removes any comments with a null task_id
# Removes any memberships with a null project_id or user_id
