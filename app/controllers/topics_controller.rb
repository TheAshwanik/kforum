class TopicsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]  
  before_filter :authenticate_user!, :only => :destroy
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    
    params[:topic][:last_poster_id] = current_user.id
    params[:topic][:last_post_at] = Time.now
    params[:topic][:user_id] = current_user.id

    @topic = Topic.new(:name => params[:topic][:name],
      :last_poster_id => params[:topic][:last_poster_id],
      :last_post_at => params[:topic][:last_post_at],
      :forum_id => params[:forum_id],
      :user_id => params[:topic][:user_id])
    
    respond_to do |format|
      if @topic.save
        format.html { redirect_to "/forums/#{@topic.forum_id}", notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to forum_url(@topic.forum_id), notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    forum_id = @topic.forum_id
    @topic.destroy

    respond_to do |format|
      format.html {  redirect_to forum_url(forum_id) , notice: 'Topic was successfully deleted.'}
      format.json { head :no_content }
    end
  end
end
