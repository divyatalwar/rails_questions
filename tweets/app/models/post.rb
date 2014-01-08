class Post < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  has_many :users, through: :tweets
  validates :content, presence: true, :length => { :maximum => 160 }

   

end
