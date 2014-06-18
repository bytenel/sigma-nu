class CreateIdentitiesTable < ActiveRecord::Migration
  def up
    create_table :identities do |t|
      t.string :email
      t.string :password
      t.string :uid
    end
  end

  def down
  end
end
