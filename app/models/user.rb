class User < ActiveRecord::Base
  rolify
  after_create :assign_reader_role
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
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

  def assign_moderator_role
   self.add_role 'moderator'
  end

  def assign_reader_role
   self.add_role 'reader'
  end
end
