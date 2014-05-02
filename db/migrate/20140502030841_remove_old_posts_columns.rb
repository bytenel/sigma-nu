class RemoveOldPostsColumns < ActiveRecord::Migration
  def change
    remove_column :posts, :posts_id
    remove_column :posts, :article_id
    remove_column :posts, :topic_id
    remove_column :posts, :forum_id
  end 
end
