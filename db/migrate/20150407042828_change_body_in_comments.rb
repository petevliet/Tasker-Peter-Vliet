class ChangeBodyInComments < ActiveRecord::Migration
  def change
    change_column :comments, :body, :text
    rename_column :comments, :body, :remark
  end
end
