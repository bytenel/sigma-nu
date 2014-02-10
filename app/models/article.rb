class Article < ActiveRecord::Base
  attr_accessible :author, :date, :description, :img-url, :title
end
#TODO: change img-url to img_url...foolish mistake
#TODO: add in model and relationship for comments