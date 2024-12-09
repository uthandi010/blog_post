class RemoveUserIdFromRoles < ActiveRecord::Migration[8.0]
  def change
    remove_column :roles, :user_id, :integer
  end
end
