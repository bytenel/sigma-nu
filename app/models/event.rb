class Event < ActiveRecord::Base
  attr_accessible :date, :description, :priority, :recurrence, :title, :user
end
