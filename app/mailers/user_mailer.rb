class UserMailer < ActionMailer::Base
   default from: "kforum.mail.agent@gmail.com"
  
   def new_post(post)
     @post = post
     @user = User.where(:mail_subscription => 't')
     puts @user.all
     for user in @user do
       if user.id != post.user_id
          @username = user.username
          sleep(2) # Make sure it doesn't get too crowded in there!
          puts "sending mail now*************"
          mail(:to => user.email, :subject => "New Post in Kforum").deliver
       end
     end  
  end
end