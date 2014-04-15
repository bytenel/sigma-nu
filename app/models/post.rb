class Post < ActiveRecord::Base
  resourcify 
  # Associations
  belongs_to :postable, :polymorphic => true
  belongs_to :user, :class_name => "User", :counter_cache => true
  belongs_to :parent, :class_name => "Post"
  has_many :posts, :foreign_key => "parent_id"   

  # Accessors
  attr_accessible :body
  attr_accessible :flag
   
  # Validations
  validates :body, :presence => true
  validates :user, :presence => true
  
  # Default Scope
  default_scope :order => 'created_at ASC'
  
  # Scope to display only the last n posts. Used for "Recent Posts" display
  scope :recent, lambda {
    |c| reorder('created_at desc').limit(c)
  }
  
  # Callbacks
  before_save :topic_locked?
  
  # Methods
  private
    def topic_locked?
      if postable.nil? ||  postable_type != "Topic"
        return
      end

      if postable.locked?
        errors.add(:base, "That topic is locked")
        false
      end
    end
end