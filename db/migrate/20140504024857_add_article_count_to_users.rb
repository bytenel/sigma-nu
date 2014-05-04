class AddArticleCountToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.column :articles_count, :integer
  	end
  end
end
