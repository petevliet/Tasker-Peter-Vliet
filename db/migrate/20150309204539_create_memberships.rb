class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :owner, null: false, default: false
    end
  end
end
