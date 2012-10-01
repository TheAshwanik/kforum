class CommentsController < ApplicationController
  before_filter :get_post, :except => [:destroy]

  # GET /comments/new
  def new
    @comment = Comment.new
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
  
  def destroy
    
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.commentable_id)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to topic_path(:id => @post.topic_id), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
   end
  
  
  def update

    @comment = Comment.find(params[:id])

    respond_to do |format|
    @comment.update_attributes(params[:comment])
      if @comment.save!
        format.html { redirect_to topic_path(:id => @post.topic_id), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /forums/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  private
    def get_post
      @post = Post.find(params[:post_id])
    end    
end