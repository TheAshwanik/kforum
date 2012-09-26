class PostsController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])  
    admin_or_owner_required(@post.user.id)
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(:content => params[:post][:content], 
    :topic_id => params[:post][:topic_id], 
    :user_id => current_user.id)  
    
    respond_to do |format|
      if @post.save
        @topic = Topic.find(@post.topic_id)  
        @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
        format.html { redirect_to "/topics/#{@post.topic_id}" , notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])  
    admin_or_owner_required(@post.user.id) 

    respond_to do |format|
      if @post.update_attributes(params[:post])
        @topic = Topic.find(@post.topic_id)  
        @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
    
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])  
    admin_or_owner_required(@post.user.id)
     
    @post.destroy

    respond_to do |format|
      format.html { redirect_to forums_url  }
      format.json { head :no_content }
    end
  end
end
