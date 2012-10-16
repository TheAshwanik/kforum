class StaticPagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:home,:about, :contact]  
  
  def home
    if params[:action] == "home"
      @home_page = true
    end
  end
  
  def create_tag_cloud 
     tags = Post.tag_counts_on(:tags, :order => (":tags DESC"))
     if tags.length > 0
        tags_by_count = Post.tag_counts_on(:tags)
        puts "tags_by_count =" + tags_by_count.inspect
        maxOccurs = tags_by_count.first.count
        minOccurs = tags_by_count.last.count
        puts "minOccurs = " + minOccurs.to_s
        puts "maxOccurs = " + maxOccurs.to_s

        # Get relative size for each of the tags and store it in a hash
        minFontSize = 5
        maxFontSize = 100
        @tag_cloud = []    
        
        i = 0
        tags.each do |tag|
            puts "******tag**************" + tag.name + "(" + tag.count.to_s + ")"
            @tag_cloud[i] = {}
            weight = (((tag.count-minOccurs).to_f/(maxOccurs-minOccurs))/2).round
            puts "weight" + weight.to_s
            size = (minFontSize + ((maxFontSize-minFontSize)*weight)).round 
            puts "size" + size.to_s
            @tag_cloud[i]['text']=tag.name
            @tag_cloud[i]['weight']=size
            i += 1
        end
        if i < 10
          @tag_cloud.clear
        end
        
        puts "***********tag_cloud*******" + @tag_cloud.inspect
       
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end