class ForumDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def formatted_last_created_post
    last_created_post = ''
     if model.posts.size > 0 
        last_created_post += 
          model.posts.last.created_at.to_s + '<br />' + model.posts.last.user.username
      else
        last_created_post += 'No Topics / Posts'
      end 

      return last_created_post.html_safe
  end

  def formatted_errors
  	  if model.errors.any?
        flash.now[:error] = model.errors.full_messages.join(', and ')
      end 
  end

end
