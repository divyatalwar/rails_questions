class Post < ActiveRecord::Base
  has_many :user_posts
  has_many :users, through: :user_posts
  # belongs_to :shared_From, :class_name => 'User', :foreign_key => 'shared_from'
  validates :content, presence: true,:length => { :maximum => 160 }
  # validates :user_id, presence: true

  
  
  

  

end
