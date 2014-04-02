class PostDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def flagged_string
    model.flag ? "Unflag" : "Flag"
  end

  def formatted_errors
 	if model.errors.any?
     flash.now[:error] = @post.errors.full_messages.join(', and ')
    end 
  end
end
