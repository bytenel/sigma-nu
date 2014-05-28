class CalendarController < ApplicationController
	layout 'no_right_side'
	
	def index
		@events = Event.all
	end
end
