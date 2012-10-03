module PostsHelper
  include ActsAsTaggableOn::TagsHelper
  
  def show_tag_cloud
     options = {:page => params[:page], :per_page => 20} # any search/pagination conditions go here
     @tags = Post.tag_counts_on(:tags)
     klass = Post
     klass = klass.tagged_with(@keyword) if (@keyword = params[:tags]).present?
     @posts = klass.paginate( options )
   end
   
end
