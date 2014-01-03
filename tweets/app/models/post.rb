class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :shared_From, :class_name => 'User', :foreign_key => 'shared_from'
  validates :content, presence: true,:length => { :maximum => 160 }
  validates :user_id, presence: true

  
  scope :by_users, ->(users) { where('user_id in (?)', users).order('created_at DESC') }

  def clone_post(user)
    Post.create(content: content, user_id: user.id, retweet: true, shared_from: user_id)
  end

  def creator?(user)
    user_id == user.id
  end

end
