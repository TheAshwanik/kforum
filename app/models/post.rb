class Post < ActiveRecord::Base
  attr_accessible :content, :user_id, :forum_id, :topic_id, :tag_list
  belongs_to :topic
  belongs_to :user
  has_many :comments
  acts_as_commentable
  acts_as_taggable_on :tags
  
  #searchable do
  #  text :content
  #end
  
  def self.search_by_content(search, page)
    if connection.adapter_name == 'PostgreSQL'
        paginate :per_page => 5, :page => page,
           :conditions => ["content ILIKE :eq", {:eq => "%#{search}%"}]
    else
        paginate :per_page => 5, :page => page,
           :conditions => ["content LIKE :eq", {:eq => "%#{search}%"}]
    end       
    
  end


end
