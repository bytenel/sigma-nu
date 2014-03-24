class AddFlagToPosts < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.column :flag, :boolean
  	end
  end
end
