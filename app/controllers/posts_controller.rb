class PostsController < ApplicationController    
    def index
     @postable = find_postable
     @posts = PostDecorator.decorate_collection(@postable.posts)
    end

    def create
     @postable = find_postable
     @post = @postable.posts.build(params[:post])
     @post.user = current_user
     if @post.save
       flash[:notice] = "Successfully created the post."
       redirect_to session[:return_to]
     else
       flash[:notice] = "Failed creating the post."
       render :action => 'new'
     end
    end

    def new
     @postable = find_postable
     @post = Post.new.decorate
     session[:return_to] = request.env['HTTP_REFERER']

     if params[:quote]
       quote_post = Post.find(params[:quote])
        if quote_post
         @post.body = quote_post.body
       end
     end
    end

    def edit
     @post = Post.find(params[:id]).decorate
    end

   def update
     @post = Post.find(params[:id])

     if @post.update_attributes(params[:post])
       flash[:notice] = "Post was successfully updated."
     end
   end

    def destroy
     @post = Post.find(params[:id])

     if @post.destroy
      flash[:notice] = "Post was successfully destroyed."
      redirect_to(:back)
     else
      flash[:error] = "The post could not be deleted."
      redirect_to(:back)
     end
   end

   def show
    redirect_to(:back)
   end

    private

    def find_postable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
       nil
     end
end