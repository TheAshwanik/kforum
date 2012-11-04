module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 30 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end
  
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar(username,email, options = { size: 60 })
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: username, class: "gravatar", :style=>options)
  end
  
  
  def find link_to_topic_for_user
     puts topic   
  end
    
end

