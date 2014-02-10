class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.datetime :date
      t.string :author
      t.string :img-url
      t.text :description

      t.timestamps
    end
  end
end
