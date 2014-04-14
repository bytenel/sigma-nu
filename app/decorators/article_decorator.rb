class ArticleDecorator < Draper::Decorator
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
  def formatted_errors
  	error_message = ""
	if model.errors.any?
     error_message += '<div id="error_explanation">
      <h2> #{ pluralize(@article.errors.count, "error") } prohibited this article from being saved:</h2>
      <ul>'
       model.errors.full_messages.each do |msg| 
       error_message += '<li> #{ msg } </li>'
       end 
     error_message += '</ul></div>'
  	end

  	return error_message.html_safe
  end

  def flag_string
    return flag ? "Unflag" : "Flag"
  end

  def inverted_flag
  	return (!flag).to_s
  end

#TODO: pretty sure i actually dont need that private helper
  def formatted_posts(current_user)
    return if model.posts.empty?
      h.content_tag :span, { :class => 'right controls' }
      self.posts.map do |post|
        if post.body.nil?
          next 
        end
         h.tag(:br) +
         h.content_tag(:span, post.created_at.to_s + ' by ' + post.user.username) +
         h.tag(:br) +
         h.content_tag(:span, post.body) +
         h.link_to("Reply", escape_string_url(Rails.application.routes.url_helpers.new_article_post_path(model)), html_options = {:class => "btn btn-mini"}) +
         h.link_to("Quote", escape_string_url(Rails.application.routes.url_helpers.new_article_post_path(model, :quote => post)), html_options = {:class => "btn btn-mini"}) +
         if current_user.posts.includes(post) 
            h.link_to("Edit", escape_string_url(Rails.application.routes.url_helpers.edit_post_path(post)), html_options = {:class => "btn btn-mini"}) +
            h.link_to("Delete", post,  html_options = {:class => "btn btn-mini btn-danger"}, :confirm => "Are you sure?", :method => :delete) 
         end
       end.join.html_safe
      end


      private

      def escape_string_url(str)
        str.gsub('/', '\\').gsub(/%5B/, '[').gsub(/%5D/, ']')
      end

end
