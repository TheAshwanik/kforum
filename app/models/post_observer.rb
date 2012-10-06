class PostObserver < ActiveRecord::Observer
  observe :post
  def after_create(post)
    UserMailer.new_post(post)
  end
end