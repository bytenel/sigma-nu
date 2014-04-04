class ChangePostsToReferencePostable < ActiveRecord::Migration
	def change
		change_table :posts do |t|
			t.references :postable, :polymorphic => true
		end
	end 
end
