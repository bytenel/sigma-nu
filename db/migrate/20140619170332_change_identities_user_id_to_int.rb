class ChangeIdentitiesUserIdToInt < ActiveRecord::Migration
  def change
    remove_column :identities, :user_id
    add_column :identities, :user_id, :integer, default: 0
  end
end
