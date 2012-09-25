class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
 def show
    @user = User.find(session["warden.user.user.key"][1][0])
  end
end