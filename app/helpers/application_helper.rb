module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "KForum"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def admin?  
    if current_user.admin == true || current_user.id == 1
      return true  
    else 
      return false  
    end  
  end  
  
  def owner?(id)  
    if current_user.id == id  
      return true  
    else  
      return false  
    end  
  end
  
  def admin_or_owner?(id)  
    if (admin? || owner?(id))  
      return true  
    else  
      return false  
    end  
  end  
  
  def find_user(id)
    @user = User.find(id)
    return @user
  end
  
  def show_flash(options={})
    options = {:fade => 1, :display => 2, :highlight => 3}.merge(options)
    html = content_tag(:div, flash.collect{ |key,msg| content_tag(:div, msg, :class => key, :attributes => "style = display: none;") }, :id => 'flash-message')
    html << content_tag(:script, "new Effect.Highlight('flash-message', {duration: #{options[:highlight]}});") if options[:highlight]
    html << content_tag(:script, "setTimeout(\"$('flash-message').fade({duration: #{options[:fade]}});\", #{options[:display]*1000}); return false;")
  end
  
  
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
  
  def find_forumName_by_topicId(id)
    @topic = Topic.find(id)
    forum_id = @topic.forum_id
    @forum = Forum.find(forum_id)
    params.merge({:forum => @forum.name,:forum_id => forum_id})
  end

end
