module ApplicationHelper
#TODO: refactor this
	def isActive?(controller, action)
		if params[:action] == action && params[:controller] == controller || \
			(params[:controller] == 'articles' && action == 'articles' || \
				params[:controller] == 'topics' && action == 'any' || \
				params[:controller] == 'forums' && action == 'any')
		   return "active"
		else
			return ""
	    end
	end

end
