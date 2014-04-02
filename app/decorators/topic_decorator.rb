class TopicDecorator < Draper::Decorator
  delegate_all
  decorates_association :posts
 
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  
  def locked_string
	model.locked ? "Unlock" : "Lock"
  end

  def sticky_string
	model.sticky ? "Unstick" : "Sticky"
  end

  def formatted_errors
   if model.errors.any? 
 	 flash.now[:error] = model.errors.full_messages.join(', and ') 
   end 
  end
end
