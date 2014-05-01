class Article < ActiveRecord::Base
  has_many :posts, :as => :postable, :dependent => :destroy
  attr_accessible :author, :date, :description, :title

  attr_accessible :photo, :flag
  
  #TODO: move YAML load statement into a helper somewhere
  has_attached_file :photo, :storage => :s3, :styles => { :medium => "300x300>",
                    :thumb => "100x100>" }, :default_url => "missing.png",
                    :s3_credentials => YAML.load(ERB.new(File.read("#{::Rails.root}/config/s3.yml")).result)
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
