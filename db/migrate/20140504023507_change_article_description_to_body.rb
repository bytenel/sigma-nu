class ChangeArticleDescriptionToBody < ActiveRecord::Migration
  def up
  	 rename_column :articles, :description, :body
  end

  def down
  end
end
