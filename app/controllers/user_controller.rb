class UserController < ApplicationController
	layout "no_col_def"
	def dashboard
    unless ENV['FEATURE_DASHBOARD']
      redirect_to root_url
    end
	end
end
