class UserMailer < ActionMailer::Base
   default from: "kforum.mail.agent@gmail.com"
  
   def new_post(post)
     @post = post
     #@user = User.where(:mail_subscription => 't').except(post.user_id)
     @user = User.find(:all, :conditions => ["id != ? AND mail_subscription == ?", post.user_id, true])


     emails = @user.collect(&:email).join(",")
     puts "*************sending mails to " + emails.to_s + "*************"
     mail(:bcc => emails , :subject => "New Post in Kforum").deliver
      
  end
end