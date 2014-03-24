class AddFlagToArticles < ActiveRecord::Migration
  def change
  	change_table :articles do |t|
  		t.column :flag, :boolean
  	end
  end
end
