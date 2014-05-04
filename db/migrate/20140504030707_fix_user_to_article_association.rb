class FixUserToArticleAssociation < ActiveRecord::Migration
  def up
  	change_column :articles, :author, 'integer USING CAST(author AS integer)'
  	rename_column :articles, :author, :user_id
  end

  def down
  end
end
