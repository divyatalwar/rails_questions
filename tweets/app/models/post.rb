class Post < ActiveRecord::Base
  has_many :user_posts
  has_many :users, through: :user_posts
  validates :content, presence: true,:length => { :maximum => 160 }
 
  
  
  

  

end
