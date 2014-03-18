class RemoveImgUrlFromArticles < ActiveRecord::Migration
  def up
  	remove_column :articles, :img_url
  end

  def down
  	add_column :articles, :img_url
  end
end
