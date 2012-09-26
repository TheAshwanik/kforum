class Post < ActiveRecord::Base
  attr_accessible :content, :user_id, :forum_id, :topic_id
  belongs_to :topic
end
