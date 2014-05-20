class User < ActiveRecord::Base
  rolify
  before_create :assign_reader_role, :add_to_mail_chimp_members_list
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  accepts_nested_attributes_for :topics, :allow_destroy => true
  accepts_nested_attributes_for :posts, :allow_destroy => true
  
  # TODO: add these
  # :confirmable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :name, :address, :city, :state, :phone, :phone_carrier, :emergency_contact_name, :emergency_contact_phone,
                  :student_id, :major
  
  validates :email, :presence => true
  validates :password, :presence => true
  validates :password_confirmation, :presence => true
  validates :username, :presence => true

  attr_accessible :avatar
  #TODO: move YAML load statement into a helper somewhere
  has_attached_file :avatar, :storage => :s3, :styles => { :medium => "300x300>",
                    :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
                    :s3_credentials => YAML.load(ERB.new(File.read("#{::Rails.root}/config/s3.yml")).result)
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_and_belongs_to_many :roles, :join_table => :users_roles
 
  def assign_moderator_role
   self.add_role :moderator
  end
 
  def assign_admin_role
   self.add_role :admin 
  end

  def assign_reader_role
   self.add_role :reader
  end

  def add_to_mail_chimp_members_list
    gb = Gibbon::API.new
    gb.lists.subscribe(
      { :id => 'a5eb726f54', 
        :email => { :email => self.email }, 
        :merge_vars => { :FNAME => self.username, :LNAME => self.username }, 
        :double_optin => false })
  end

  def remove_from_mail_chimp_members_list
    gb = Gibbon::API.new
    gb.lists.unsubscribe(
      :id => 'a5eb726f54', 
      :email => {:email => self.email },
      :delete_member => true, 
      :send_notify => true)
  end

end
