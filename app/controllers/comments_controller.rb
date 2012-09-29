class CommentsController < ApplicationController
  before_filter :get_post

  # GET /comments/new
  def new
    @comment = Comment.new
    puts "ashwani-comments"
    puts params
    respond_to do |format|
      format.html
      format.js { render new_comment_path }
    end
  end
  
  def create
    @post = Post.find(params[:comment][:commentable_id])
    @user = @post.user_id
    @user_who_commented = current_user
    @comment_body = params[:comment][:body]
    

    @comment = Comment.build_from(@post, @user_who_commented.id, @comment_body )
    if @comment.save
    respond_to do |format|
        format.html { redirect_to "/topics/#{@post.topic_id}", notice: 'Comment was successfully created.' }
    end
    end
    
  end


  private
    def get_post
      puts "ashwani-comments-get_post"
      puts params    
      puts "ashwani-comments-get_post ends"
      @post = Post.find(params[:post_id])
    end    
end