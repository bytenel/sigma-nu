class ArticleDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def formatted_erros
  	error_message = ""
	if this.errors.any?
     error_message += '<div id="error_explanation">
      <h2> #{ pluralize(@article.errors.count, "error") } prohibited this article from being saved:</h2>
      <ul>'
       this.errors.full_messages.each do |msg| 
       error_message += '<li> #{ msg } </li>'
       end 
     error_message += '</ul></div>'
  	end

  	return error_message
  end

  def flag_string
    return flag ? "Unflag" : "Flag"
  end

  def inverted_flag
	return (!flag).to_s
  end

  def formatted_posts
  	formatted_posts = ""
  	posts.each do |post| 
	    if post.body.nil?
	      next 
	    end 

	  formatted_posts += 
	  "<br />
	  #{ post.user.username }  :   #{ post.created_at } 
	  <br/>
	  #{ post.body }" 
	 end 
   return formatted_posts
  end
end
