class AddingExtraInfoToUser < ActiveRecord::Migration
  def up
  	 add_column :users, :name, :string  
  	 add_column :users, :address, :string  
  	 add_column :users, :city, :string  
  	 add_column :users, :state, :string  
  	 add_column :users, :phone, :string  
  	 add_column :users, :phone_carrier, :string  
  	 add_column :users, :emergency_contact_name, :string  
  	 add_column :users, :emergency_contact_phone, :string  
  	 add_column :users, :student_id, :string  
  	 add_column :users, :major, :string  
  end

  def down
  end
end
