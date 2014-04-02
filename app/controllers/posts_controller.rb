class PostsController < ApplicationController    
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    
    if params[:quote]
      quote_post = Post.find(params[:quote])
      if quote_post
        @post.body = quote_post.body
      end
    end
  end
  
  def create
    if(params[:topic_id].nil?)
      article_post = true
      @article = Article.find(params[:article_id])
      @post = @article.posts.build(params[:post])
     else 
      @topic = Topic.find(params[:topic_id])
      @post = @topic.posts.build(params[:post])
      @post.forum = @topic.forum
    end

    @post.user = current_user
    if @post.save
      flash[:notice] = "Post was successfully created."
      if article_post
        redirect_to article_path(@post.article)
      else
        redirect_to topic_path(@post.topic)
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id]).decorate
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:notice] = "Post was successfully updated."
      redirect_to topic_path(@post.topic)
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.topic.posts_count > 1
      if @post.destroy
        flash[:notice] = "Post was successfully destroyed."
        redirect_to topic_path(@post.topic)
      end
    else
      if @post.topic.destroy
        flash[:notice] = "Topic was successfully deleted."
        redirect_to forum_path(@post.forum)
      end
    end
  end
end