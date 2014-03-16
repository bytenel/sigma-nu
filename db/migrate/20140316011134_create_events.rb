class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.integer :user_id
      t.string :description
      t.string :recurrence
      t.integer :priority
      t.string :title

      t.timestamps
    end
  end
end
