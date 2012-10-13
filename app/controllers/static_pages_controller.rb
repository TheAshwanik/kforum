class StaticPagesController < ApplicationController
  def home
    if params[:action] == "home"
      @home_page = true
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end