class AddPhotoColumnsToArticles < ActiveRecord::Migration
  def up
  	add_attachment :articles, :photo
  end

  def down
  	remove_attachment :articles, :photo
  end
end
