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

private
  def assign_reader_role
    self.add_role "reader"
  end
end
