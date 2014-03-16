class Article < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  attr_accessible :author, :date, :description, :img_url, :title
end
