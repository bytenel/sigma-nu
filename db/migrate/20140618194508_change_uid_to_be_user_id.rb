class ChangeUidToBeUserId < ActiveRecord::Migration
  def change
    rename_column :identities, :uid, :user_id
  end 
end
