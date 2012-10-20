class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :user_id, :mail_subscription
  attr_accessible :email, :password, :password_confirmation, :username, :admin ,:mail_subscription , :as => :admin
  # attr_accessible :title, :body
  attr_protected :admin
  
  has_many :posts, :dependent => :destroy
  has_many :topics
  
  acts_as_tagger
  
end
