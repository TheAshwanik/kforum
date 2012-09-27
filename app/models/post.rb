class Post < ActiveRecord::Base
  attr_accessible :content, :user_id, :forum_id, :topic_id
  belongs_to :topic
  belongs_to :user
  has_many :comments
end
