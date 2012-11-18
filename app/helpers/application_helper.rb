module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "KForum - For KIS, KPSA , Kabira Developers"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
    
  def meta_keywords(tags = nil)
    if tags.present?
      content_for :meta_keywords, tags
    else
      content_for?(:meta_keywords) ? [content_for(:meta_keywords), META_CONFIG['meta_keywords']].join(', ') : META_CONFIG['meta_keywords']
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : META_CONFIG['meta_description']
    end
  end

  def adminuser?  
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
    if (adminuser? || owner?(id))  
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
  
  def find_TopicName_by_Id(id)
    @topic = Topic.find(id)
    params.merge({:topic_name => @topic.name, :topic_id => @topic.id})
  end

  def truncate(text, max_sentences = 3, max_words = 5)
    # Take first 3 setences (blah. blah. blah)
    three_sentences = text.split('. ').slice(0, max_sentences).join('. ')
    # Take first 50 words of the above
    shortened = three_sentences.split(' ').slice(0, max_words).join(' ')
    return shortened # bah, explicit return is evil
  end
  
  def menu_for(bar,&block)
    menu_items = ["Forum","Edit Setting"]
    path_of = { "Forum" => main_app.forums_path,
                "Edit Setting" => main_app.edit_user_registration_path }
                
    menu_items.each do |item|
      if item == bar and block_given?
        concat content_tag(:li,link_to(item, path_of[item]),
  	                       :class => 'selected')
        sub_menu = content_tag(:div,:id => 'sub_menu') do
          capture(&block)
        end
        concat sub_menu
      else
        concat content_tag(:li,link_to(item, path_of[item]))
      end
    end
  end # end of menu_for

end
