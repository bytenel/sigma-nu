class User < ActiveRecord::Base
  rolify
  before_create :assign_reader_role, :add_to_mail_chimp_members_list
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :identities

  accepts_nested_attributes_for :topics, :allow_destroy => true
  accepts_nested_attributes_for :posts, :allow_destroy => true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

         # TODO: add :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :name, :address, :city, :state, :phone, :phone_carrier, :emergency_contact_name, :emergency_contact_phone,
                  :student_id, :major
  
  validates :email, :presence => true
  validates :password, :presence => true
  validates :password_confirmation, :presence => true

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

   def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    identity = identity ? identity : Identity.new

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        password = Devise.friendly_token[0,20]
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{auth.uid}-#{auth.provider}.com",
          password: password,
          password_confirmation: password
        )
        
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

end
