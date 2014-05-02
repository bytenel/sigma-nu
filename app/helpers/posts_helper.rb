module PostsHelper
	def render_posts(post)
	  final_nodes = "" 
		  post.posts.each do |post| 
		  	  unless post.posts.nil?
		  	  	final_nodes += render_posts(post)
		  	  end
	            final_nodes +=
	               " <thead>
	                      <th class='post_author' rowspan='2'>
	                        <span class='name'>#{post.user.username}</span>
	                        <span class='avatar'><!-- This space reserved for Avatar --></span>
	                        <span class='left post_date smaller'>#{post.created_at}</span>
	                        <span class='right controls'>
	                           #{link_to post.flagged_string, 
	                           {:controller => 'posts', :action => 'update', :post => {:flag => !post.flag }}, 
	                           html_options = {:method => :put }}
	                           #{link_to "Reply", new_post_post_path(post)}
	                           #{link_to "Quote", new_topic_post_path(@topic, :quote => post)}"

	            if current_user.posts.includes(post)
	                final_nodes += "#{link_to "Edit", edit_post_path(post)}
	                           #{button_to "Delete", post, html_options = 
	                           {:class => "btn btn-mini btn-danger", :confirm => "Are you sure?", :method => :delete}}"
                end
	            final_nodes += 
	                "</span>
	                      </th>
	                  </thead>
	                  <tbody>
	                    <tr>
	                      <td class='post_body'>
	                       #{ simple_format(auto_link(post.body)) }
	                    </td>
	                    </tr>
	                  </tbody>"
     	  end 
     	return final_nodes.html_safe
    end
end
