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
           :conditions => ["(content ILIKE :cond1) OR (content ILIKE :cond2) OR (content ILIKE :cond3) OR (content ILIKE :cond4)
                OR (content ILIKE :cond5) OR (content ILIKE :cond6)",
             { :cond1 => "%#{search}%", :cond2 => "%#{search.gsub(/\s+/, "")}%",
             :cond3 => "%#{search.singularize}%", :cond4 => "%#{search.singularize.gsub(/\s+/, "")}%",
             :cond5 => "%#{search.pluralize}%", :cond6 => "%#{search.pluralize.gsub(/\s+/, "")}%"
              }
             ]
    else
        paginate :per_page => 5, :page => page,
           :conditions => ["(content LIKE :cond1) OR (content LIKE :cond2) OR (content LIKE :cond3) OR (content LIKE :cond4)
                OR (content LIKE :cond5) OR (content LIKE :cond6)",
             { :cond1 => "%#{search}%", :cond2 => "%#{search.gsub(/\s+/, "")}%",
             :cond3 => "%#{search.singularize}%", :cond4 => "%#{search.singularize.gsub(/\s+/, "")}%",
             :cond5 => "%#{search.pluralize}%", :cond6 => "%#{search.pluralize.gsub(/\s+/, "")}%"
              }
             ]
      end

  end


end
