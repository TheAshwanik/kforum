module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def admin?  
    if current_user.admin == true || current_user.id == 1
      puts "True ashwani"  
      return true  
    else
      puts "False ashwani"  
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
  
end
