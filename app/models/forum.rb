class Forum < ActiveRecord::Base
  attr_accessible :description, :name, :forum_id
  has_many :topics, :dependent => :destroy
  
  def most_recent_post  
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])  
    return topic  
  end  

end
