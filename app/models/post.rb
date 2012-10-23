class Post < ActiveRecord::Base
  attr_accessible :content, :user_id, :forum_id, :topic_id, :tag_list
  belongs_to :topic
  belongs_to :user
  has_many :comments
  acts_as_commentable
  acts_as_taggable_on :tags
  
  searchable do
    text :content
  end
  
end
